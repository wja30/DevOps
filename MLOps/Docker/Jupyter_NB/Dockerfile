# Use the official Jupyter base image
FROM jupyter/base-notebook

# Switch to root to create a new user 'jkim'
USER root

# Create a new user 'jkim' with home directory /home/jkim
RUN useradd -m -s /bin/bash -N -u 1001 jkim

# Set the working directory to /home/jkim/work
WORKDIR /home/jkim/work

# Change ownership of the working directory to 'jkim'
RUN chown -R jkim:users /home/jkim

# Set the HOME environment variable to /home/jkim
ENV HOME=/home/jkim

# Switch to 'jkim' user for all subsequent commands
USER jkim

# Copy requirements.txt into the container
COPY requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Install the latest conda package and create a conda environment with python 3.10 and PyTorch
RUN conda install -y conda && \
    conda create -n conda_python3 python=3.10 && \
    /opt/conda/bin/conda install -n conda_python3 pytorch torchvision torchaudio -c pytorch && \
    conda clean -afy

# Install the ipykernel in the conda environment
RUN /opt/conda/bin/conda install -n conda_python3 ipykernel && \
    /opt/conda/bin/conda run -n conda_python3 python -m ipykernel install --user --name conda_python3 --display-name "PyTorch_3.10(python)"

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Command to run Jupyter Notebook
CMD ["start-notebook.sh", "--NotebookApp.token=''"]
