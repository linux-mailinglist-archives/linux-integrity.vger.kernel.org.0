Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF271C6D47
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgEFJlR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 05:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729168AbgEFJlO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 05:41:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD063C061A41
        for <linux-integrity@vger.kernel.org>; Wed,  6 May 2020 02:41:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so264409plt.5
        for <linux-integrity@vger.kernel.org>; Wed, 06 May 2020 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxSG5WfhkxEMB45TkG3LoWeSX6r+HmcNcuK6/XuJqfE=;
        b=Cz3qjql4oGUV5mHZ/9oLh+l4ZsRg/D4Fz6/A4C0SdSBUJKGQcl4tKl6ZAX6lUYP3UR
         jUz658tzNq5IgBDWcizEHsM9kbxc4I1gXumbJcFmFbEvx9+g5xOEtXBp0M+YCyi7d6e9
         RA80wL+aQSUfEdlix66YRYJ4ljFDDQVuZgA8kHFeoq/s+Cko7ITcl3iEnNbDt9CvxXza
         3oL8z35oH2GhuukjTQCzFjENcQgyIXZ0no3bOuGMEk/1eij1e/HynYflKHuQ2wkqEiwf
         W4fyjdAMVrbI9xyR7H174CaE/DAPuBWj1XvOa598Ed6X60KgZVCSXAtWDvSX3uGDwLum
         RpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxSG5WfhkxEMB45TkG3LoWeSX6r+HmcNcuK6/XuJqfE=;
        b=T9mBGyqfFBpEaHGRvyiwSvbsla3eCC1bpIbfRLB4RuJObLomgvqyHYf7WqjcGUJEVC
         OLdrHSypEwG8jvvbzHNRlkb+icZu3tlMP+cDtk45E+LuXPhymen1PUtYvwr967bxwiXt
         zA0jEFBCzwUymIeGd0E/Vap5XxaF2pUKA4I/Uv16sUNmJ0+jl+5T2vWStlcb506IWiEs
         Dtwqs2fDQrOkERdQrAlDnSBZhni4G47yQK/cqRZPvo8G40n6krJn32SbyT2kYt7Ai6+S
         YiVQ2BV7cwuieltgRdo8CZAfOZOxVFlsSPZTtuItBxmNqaRXwpXsZA3zYeT5eycPzDAF
         hZYg==
X-Gm-Message-State: AGi0PuaNUyzxdZUCv3AQhNOpRsKBCgIa2WmGKo5abhzTgnyaIGW3nOaW
        6uTXA2JWGOM3OzIPNSmJ5/FAHA==
X-Google-Smtp-Source: APiQypL8PVNAtbX6SZbxqYBbtEbgTFb0q34Wb8hMyWomxwoyM+3ATnIXBOZ+d8Us2atsIRlin9bZQQ==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr1642200plz.27.1588758073190;
        Wed, 06 May 2020 02:41:13 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.141])
        by smtp.gmail.com with ESMTPSA id a2sm1337360pfg.106.2020.05.06.02.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 02:41:12 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date:   Wed,  6 May 2020 15:10:15 +0530
Message-Id: <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
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
index 47c0415..6ca6bc7 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -84,6 +84,9 @@ config TRUSTED_KEYS
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
index 9bfd081..03555ed 100644
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

