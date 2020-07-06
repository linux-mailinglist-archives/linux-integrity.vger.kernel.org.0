Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F5216226
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 01:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGFXYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgGFXYF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 19:24:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95CC061755
        for <linux-integrity@vger.kernel.org>; Mon,  6 Jul 2020 16:24:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d15so36819119edm.10
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCHL24pJFJSFoASanMhktjUvoQlUfrXyegYhzckyoiE=;
        b=VbsulSNVum8Xox31K2vkZ75sExmmLfThOy1tO3cZELgoRxBgnbf1QAJdvoFa6B4EmJ
         YjUWtsJoaHbjnLVYLFH7dHdFPTFi2bO9FnGHJRjyN4SGFdn/mohwpOIBo+PiiD194e5/
         LdpyQo8zpZkZXCtIg0zYoMDaqqSV2HaDr9vwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sCHL24pJFJSFoASanMhktjUvoQlUfrXyegYhzckyoiE=;
        b=iClCmb5zRqtYutESlSa+BdXo/rI+Z8HWHHC8OGyM8XojQFkXO2c50W1nkmPT3VnL65
         gjqBY3oApkCsUo6kfU8rPDmmN9QACJQNLJd4pdxPsacEHd4aTG6lltdtwtNqWFpjtUJ8
         TjR593REryY1mlYjTbL7ZvcDr1Bwi+3OQD9p07EtgNBA7rgwDOgalV/zdbQg4UvGtCsp
         tUhQr+l1lL87yL3eWx7D4yQN9FmUUnPQ2EQnsBa5k6OQl6PtOjLB7Vph3D3kYRxmTIGE
         NjhvE44AyD2GOs06Pr9azxU9UirGDb5K2LxrSu3Q1uXD65W7TVXVI/HEOmztUl3o+XZT
         /rGA==
X-Gm-Message-State: AOAM533dvengkjsfLfuNXpscwS+InToGzwfeSXWxAZUyNLgCZ4MM+vEl
        5DeYJQEvIlKLrWH5W7umgdjirA==
X-Google-Smtp-Source: ABdhPJxAbXjF+Gs6sYum2Xf3mUIFZlbOyFQCxU889QiaLBq9vuFgNeTH9ifaFNpkLKQ6ecEYdv9w5Q==
X-Received: by 2002:a50:dacf:: with SMTP id s15mr60970729edj.136.1594077843678;
        Mon, 06 Jul 2020 16:24:03 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i2sm4002567ejp.114.2020.07.06.16.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:24:03 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v10 5/9] firmware: test partial file reads of request_partial_firmware_into_buf
Date:   Mon,  6 Jul 2020 16:23:05 -0700
Message-Id: <20200706232309.12010-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706232309.12010-1-scott.branden@broadcom.com>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add firmware tests for partial file reads of
request_partial_firmware_into_buf.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..afc2e469ac06 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -149,6 +149,26 @@ config_unset_into_buf()
 	echo 0 >  $DIR/config_into_buf
 }
 
+config_set_buf_size()
+{
+	echo $1 >  $DIR/config_buf_size
+}
+
+config_set_file_offset()
+{
+	echo $1 >  $DIR/config_file_offset
+}
+
+config_set_partial()
+{
+	echo 1 >  $DIR/config_partial
+}
+
+config_unset_partial()
+{
+	echo 0 >  $DIR/config_partial
+}
+
 config_set_sync_direct()
 {
 	echo 1 >  $DIR/config_sync_direct
@@ -207,6 +227,35 @@ read_firmwares()
 	done
 }
 
+read_partial_firmwares()
+{
+	if [ "$(cat $DIR/config_into_buf)" == "1" ]; then
+		fwfile="${FW_INTO_BUF}"
+	else
+		fwfile="${FW}"
+	fi
+
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${fwfile}-orig"
+	fi
+
+	# Strip fwfile down to match partial offset and length
+	partial_data="$(cat $fwfile)"
+	partial_data="${partial_data:$2:$3}"
+
+	for i in $(seq 0 3); do
+		config_set_read_fw_idx $i
+
+		read_firmware="$(cat $DIR/read_firmware)"
+
+		# Verify the contents are what we expect.
+		if [ $read_firmware != $partial_data ]; then
+			echo "request #$i: partial firmware was not loaded" >&2
+			exit 1
+		fi
+	done
+}
+
 read_firmwares_expect_nofile()
 {
 	for i in $(seq 0 3); do
@@ -319,6 +368,21 @@ test_batched_request_firmware_into_buf()
 	echo "OK"
 }
 
+test_batched_request_partial_firmware_into_buf()
+{
+	echo -n "Batched request_partial_firmware_into_buf() $2 off=$3 size=$4 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $4
+	config_set_file_offset $3
+	config_trigger_sync
+	read_partial_firmwares $2 $3 $4
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct()
 {
 	echo -n "Batched request_firmware_direct() $2 try #$1: "
@@ -371,6 +435,22 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware_into_buf $i normal
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 0 10
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 0 5
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 1 6
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_partial_firmware_into_buf $i normal 2 10
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
-- 
2.17.1

