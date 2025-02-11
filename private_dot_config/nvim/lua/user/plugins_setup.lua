require("remote-nvim").setup({
  devpod = {
    binary = "devpod", -- Verify this is correct for your system
    docker_binary = "podman", -- Test with "docker", change to "podman" if needed
  },
})
