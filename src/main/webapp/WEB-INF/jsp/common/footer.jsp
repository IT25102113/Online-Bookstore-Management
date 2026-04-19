
            </section>

            <!-- Footer -->
            <footer class="mt-auto p-6 text-center border-t border-accent/20">
                <p class="text-secondary text-sm">&copy; 2026 BookLeaf Premium Online Bookstore. All Rights Reserved.</p>
            </footer>
        </main>
    </div>

    <!-- ============================================================ -->
    <!-- GLOBAL JAVASCRIPT -->
    <!-- ============================================================ -->
    <script>
        // Auto-close toasts
        setTimeout(() => {
            document.querySelectorAll('[id^="toast"]').forEach(el => {
                el.classList.replace('toast-enter', 'toast-exit');
                setTimeout(() => el.remove(), 500);
            });
        }, 4000);

        function closeToast(id) {
            const el = document.getElementById(id);
            if (el) {
                el.classList.replace('toast-enter', 'toast-exit');
                setTimeout(() => el.remove(), 500);
            }
        }

        // Profile Dropdown
        function toggleDropdown() {
            const menu = document.getElementById('dropdownMenu');
            menu.classList.toggle('hidden');
        }

        // Close dropdown on outside click
        document.addEventListener('click', function(e) {
            const dropdown = document.getElementById('profileDropdown');
            const menu = document.getElementById('dropdownMenu');
            if (dropdown && menu && !dropdown.contains(e.target)) {
                menu.classList.add('hidden');
            }
        });

        // Modal toggle function
        function toggleModal(id) {
            const modal = document.getElementById(id);
            if (modal) {
                modal.classList.toggle('hidden');
                modal.classList.toggle('flex');
            }
        }
    </script>
</body>
</html>
