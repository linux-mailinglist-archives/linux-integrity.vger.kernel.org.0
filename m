Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B95EB1E5
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJaOAQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 10:00:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43221 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfJaOAQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 10:00:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id a18so1602106plm.10
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tV3YdYOF+N6UHAU6eCK1RFhDN2cqefuz5QUFK90oG0E=;
        b=OvH4AeDgTbhIkBZGp0TQgcWXJcsuzuRjBYfCXxK6UmaYdCG/MV9s7BDQd5K8dWQfcn
         OdnCagEgtscMK75ssAPM4AZbhwz1jnnVPnuXaFyPaYeIbOeBLlB++LK9g2zABqtll4Rp
         +aZq3pEY7AYQ86QL/ty3uR0BO+vAkwjau7QtVufIR6pu5z2jObW5q09b27Vwv+XbcYBS
         k8mrdrMnHnVPBS/0OpWfqihiEJRc5fAUVJNOp8ey4+wjDbJzv8UgGRRpB4/fioesTHrQ
         foLkjUaZoeIx3Yiq5wbnks59FmRPvbsfZvKYkvHBZU8zFEtRWytzDTTTL1rluFYMPxw3
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tV3YdYOF+N6UHAU6eCK1RFhDN2cqefuz5QUFK90oG0E=;
        b=tjjpS84kEo3sCOrGmO1MGPwI1Li9SxvTqMqyCS/R0qHe2a+3TO8GRZE43JK+2RTiMK
         +MWQgyHDYSf8wMHy+xvdBePtIr/8j+QEECq2rlG25FADPsT42uI7W9R8V+TmTdOytiQo
         9XX0mav4GLTN8ecMShc5G1e3aXQZGfsF4tTNooCLoUcygTLmDadNn/FgnFy+u5dOBvmc
         p84ggVk6NkNOAsiFAEWg7DvBSFl0gDtm1pXRTORMaK+qy4sCNmk1yqFHT5BYmxZ36hlk
         tqp+Q1TFrxTrNscXLbMlGCqtNsKHVVsn99CPU1rrjyo203PmB51hhjVKFiPBgyfBQhoq
         iGgA==
X-Gm-Message-State: APjAAAWX551w7iKCAdeAQ6dfoCmHDynD/5ZSQPQXb/z1R0QGiEzDKJoo
        LPVgYSabFU93PwvaiwgkMN9/Bw==
X-Google-Smtp-Source: APXvYqw2ClUwIgO5Jk3gxRZklBJXlQ8B/mnSfsyCk/TfumCAQxPsmrrR6U5YNRBQFFT3FZL3BHbPoA==
X-Received: by 2002:a17:902:fe96:: with SMTP id x22mr6578309plm.72.1572530414887;
        Thu, 31 Oct 2019 07:00:14 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.07.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 07:00:14 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 5/7] KEYS: trusted: Introduce TEE based Trusted Keys
Date:   Thu, 31 Oct 2019 19:28:41 +0530
Message-Id: <1572530323-14802-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key.

Refer to Documentation/tee.txt for detailed information about TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/keys/trusted-type.h                 |   3 +
 include/keys/trusted_tee.h                  |  66 +++++++
 security/keys/Kconfig                       |   3 +
 security/keys/trusted-keys/Makefile         |   1 +
 security/keys/trusted-keys/trusted_common.c |   3 +
 security/keys/trusted-keys/trusted_tee.c    | 282 ++++++++++++++++++++++++++++
 6 files changed, 358 insertions(+)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 5559010..e0df5df 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -67,6 +67,9 @@ extern struct key_type key_type_trusted;
 #if defined(CONFIG_TCG_TPM)
 extern struct trusted_key_ops tpm_trusted_key_ops;
 #endif
+#if defined(CONFIG_TEE)
+extern struct trusted_key_ops tee_trusted_key_ops;
+#endif
 
 #define TRUSTED_DEBUG 0
 
diff --git a/include/keys/trusted_tee.h b/include/keys/trusted_tee.h
new file mode 100644
index 0000000..ab58ffd
--- /dev/null
+++ b/include/keys/trusted_tee.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ *
+ * Author:
+ * Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef __TEE_TRUSTED_KEY_H
+#define __TEE_TRUSTED_KEY_H
+
+#include <linux/tee_drv.h>
+
+#define DRIVER_NAME "tee-trusted-key"
+
+/*
+ * Get random data for symmetric key
+ *
+ * [out]     memref[0]        Random data
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_GET_RANDOM	0x0
+
+/*
+ * Seal trusted key using hardware unique key
+ *
+ * [in]      memref[0]        Plain key
+ * [out]     memref[1]        Sealed key datablob
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_SEAL		0x1
+
+/*
+ * Unseal trusted key using hardware unique key
+ *
+ * [in]      memref[0]        Sealed key datablob
+ * [out]     memref[1]        Plain key
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_UNSEAL		0x2
+
+/**
+ * struct trusted_key_private - TEE Trusted key private data
+ * @dev:		TEE based Trusted key device.
+ * @ctx:		TEE context handler.
+ * @session_id:		Trusted key TA session identifier.
+ * @shm_pool:		Memory pool shared with TEE device.
+ */
+struct trusted_key_private {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+	u32 data_rate;
+	struct tee_shm *shm_pool;
+};
+
+#endif
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index dd31343..0d5e37c 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -88,6 +88,9 @@ config TRUSTED_KEYS
 	  if the boot PCRs and other criteria match.  Userspace will only ever
 	  see encrypted blobs.
 
+	  It also provides support for alternative TEE based Trusted keys
+	  generation and sealing in case TPM isn't present.
+
 	  If you are unsure as to whether this is required, answer N.
 
 config ENCRYPTED_KEYS
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 2b1085b..ea937d3 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_common.o
 trusted-y += trusted_tpm1.o
 trusted-y += trusted_tpm2.o
+trusted-y += trusted_tee.o
diff --git a/security/keys/trusted-keys/trusted_common.c b/security/keys/trusted-keys/trusted_common.c
index 8f00fde..a0a171f 100644
--- a/security/keys/trusted-keys/trusted_common.c
+++ b/security/keys/trusted-keys/trusted_common.c
@@ -27,6 +27,9 @@ static struct trusted_key_ops *available_tk_ops[] = {
 #if defined(CONFIG_TCG_TPM)
 	&tpm_trusted_key_ops,
 #endif
+#if defined(CONFIG_TEE)
+	&tee_trusted_key_ops,
+#endif
 };
 static struct trusted_key_ops *tk_ops;
 
diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
new file mode 100644
index 0000000..724a73c
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ *
+ * Author:
+ * Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/key-type.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uuid.h>
+
+#include <keys/trusted-type.h>
+#include <keys/trusted_tee.h>
+
+static struct trusted_key_private pvt_data;
+
+/*
+ * Have the TEE seal(encrypt) the symmetric key
+ */
+static int tee_key_seal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
+				      p->key_len, TEE_SHM_DMA_BUF |
+				      TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_in)) {
+		dev_err(pvt_data.dev, "key shm register failed\n");
+		return PTR_ERR(reg_shm_in);
+	}
+
+	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
+				       sizeof(p->blob), TEE_SHM_DMA_BUF |
+				       TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_out)) {
+		dev_err(pvt_data.dev, "blob shm register failed\n");
+		ret = PTR_ERR(reg_shm_out);
+		goto out;
+	}
+
+	inv_arg.func = TA_CMD_SEAL;
+	inv_arg.session = pvt_data.session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm = reg_shm_in;
+	param[0].u.memref.size = p->key_len;
+	param[0].u.memref.shm_offs = 0;
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm = reg_shm_out;
+	param[1].u.memref.size = sizeof(p->blob);
+	param[1].u.memref.shm_offs = 0;
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_SEAL invoke err: %x\n",
+			inv_arg.ret);
+		ret = -EFAULT;
+	} else {
+		p->blob_len = param[1].u.memref.size;
+	}
+
+out:
+	if (reg_shm_out)
+		tee_shm_free(reg_shm_out);
+	if (reg_shm_in)
+		tee_shm_free(reg_shm_in);
+
+	return ret;
+}
+
+/*
+ * Have the TEE unseal(decrypt) the symmetric key
+ */
+static int tee_key_unseal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
+				      p->blob_len, TEE_SHM_DMA_BUF |
+				      TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_in)) {
+		dev_err(pvt_data.dev, "blob shm register failed\n");
+		return PTR_ERR(reg_shm_in);
+	}
+
+	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
+				       sizeof(p->key), TEE_SHM_DMA_BUF |
+				       TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_out)) {
+		dev_err(pvt_data.dev, "key shm register failed\n");
+		ret = PTR_ERR(reg_shm_out);
+		goto out;
+	}
+
+	inv_arg.func = TA_CMD_UNSEAL;
+	inv_arg.session = pvt_data.session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm = reg_shm_in;
+	param[0].u.memref.size = p->blob_len;
+	param[0].u.memref.shm_offs = 0;
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm = reg_shm_out;
+	param[1].u.memref.size = sizeof(p->key);
+	param[1].u.memref.shm_offs = 0;
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_UNSEAL invoke err: %x\n",
+			inv_arg.ret);
+		ret = -EFAULT;
+	} else {
+		p->key_len = param[1].u.memref.size;
+	}
+
+out:
+	if (reg_shm_out)
+		tee_shm_free(reg_shm_out);
+	if (reg_shm_in)
+		tee_shm_free(reg_shm_in);
+
+	return ret;
+}
+
+/*
+ * Have the TEE generate random symmetric key
+ */
+static int tee_get_random(unsigned char *key, size_t key_len)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm = NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm = tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
+				   TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm)) {
+		dev_err(pvt_data.dev, "random key shm register failed\n");
+		return PTR_ERR(reg_shm);
+	}
+
+	inv_arg.func = TA_CMD_GET_RANDOM;
+	inv_arg.session = pvt_data.session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm = reg_shm;
+	param[0].u.memref.size = key_len;
+	param[0].u.memref.shm_offs = 0;
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_GET_RANDOM invoke err: %x\n",
+			inv_arg.ret);
+		ret = -EFAULT;
+	} else {
+		ret = param[0].u.memref.size;
+	}
+
+	tee_shm_free(reg_shm);
+
+	return ret;
+}
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int trusted_key_probe(struct device *dev)
+{
+	struct tee_client_device *rng_device = to_tee_client_device(dev);
+	int ret = 0, err = -ENODEV;
+	struct tee_ioctl_open_session_arg sess_arg;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	/* Open context with TEE driver */
+	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
+					       NULL);
+	if (IS_ERR(pvt_data.ctx))
+		return -ENODEV;
+
+	/* Open session with hwrng Trusted App */
+	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params = 0;
+
+	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n",
+			sess_arg.ret);
+		err = -EINVAL;
+		goto out_ctx;
+	}
+	pvt_data.session_id = sess_arg.session;
+
+	ret = register_key_type(&key_type_trusted);
+	if (ret < 0)
+		goto out_sess;
+
+	pvt_data.dev = dev;
+
+	return 0;
+
+out_sess:
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+out_ctx:
+	tee_client_close_context(pvt_data.ctx);
+
+	return err;
+}
+
+static int trusted_key_remove(struct device *dev)
+{
+	unregister_key_type(&key_type_trusted);
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+
+	return 0;
+}
+
+static const struct tee_client_device_id trusted_key_id_table[] = {
+	{UUID_INIT(0xf04a0fe7, 0x1f5d, 0x4b9b,
+		   0xab, 0xf7, 0x61, 0x9b, 0x85, 0xb4, 0xce, 0x8c)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
+
+static struct tee_client_driver trusted_key_driver = {
+	.id_table	= trusted_key_id_table,
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.bus		= &tee_bus_type,
+		.probe		= trusted_key_probe,
+		.remove		= trusted_key_remove,
+	},
+};
+
+static int __init init_tee_trusted(void)
+{
+	return driver_register(&trusted_key_driver.driver);
+}
+
+static void __exit cleanup_tee_trusted(void)
+{
+	driver_unregister(&trusted_key_driver.driver);
+}
+
+struct trusted_key_ops tee_trusted_key_ops = {
+	.migratable = 0, /* non-migratable */
+	.init = init_tee_trusted,
+	.seal = tee_key_seal,
+	.unseal = tee_key_unseal,
+	.get_random = tee_get_random,
+	.cleanup = cleanup_tee_trusted,
+};
+EXPORT_SYMBOL_GPL(tee_trusted_key_ops);
-- 
2.7.4

