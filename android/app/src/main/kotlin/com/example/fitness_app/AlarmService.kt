import android.app.Service
import android.content.Intent
import android.os.IBinder

class AlarmService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // Keep the service running
        return START_STICKY
    }
}