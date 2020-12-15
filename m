Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3002DB412
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Dec 2020 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgLOSw6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Dec 2020 13:52:58 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:33180 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731761AbgLOSw2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Dec 2020 13:52:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4CBFD1280905;
        Tue, 15 Dec 2020 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608058305;
        bh=zX/MuXcp/zR4JcIdAhm1GoFpmG3JdWl2ezvg0CIiimQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AXBCp7Ru0XvZnsnQ0Y4E/KJGmvVIof7W2fF5WQQ1qQzL+gLF5n0S3mvnls3E1n0SZ
         86HpEZiVowkMBngkq4lgZWXg0fr6xtcd8vaBbQq/+u+mjBce8+eHIXMpnsVOzpPRcz
         2/y/kXGS0w1WLyzv6HnEgrUyFln1+8gr88UGZcUk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dbHRUO6ilrLJ; Tue, 15 Dec 2020 10:51:45 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C37DC12808F8;
        Tue, 15 Dec 2020 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608058305;
        bh=zX/MuXcp/zR4JcIdAhm1GoFpmG3JdWl2ezvg0CIiimQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AXBCp7Ru0XvZnsnQ0Y4E/KJGmvVIof7W2fF5WQQ1qQzL+gLF5n0S3mvnls3E1n0SZ
         86HpEZiVowkMBngkq4lgZWXg0fr6xtcd8vaBbQq/+u+mjBce8+eHIXMpnsVOzpPRcz
         2/y/kXGS0w1WLyzv6HnEgrUyFln1+8gr88UGZcUk=
Message-ID: <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Dec 2020 10:51:43 -0800
In-Reply-To: <20201215133801.546207-1-s.temerkhanov@gmail.com>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-15 at 16:38 +0300, Sergey Temerkhanov wrote:
> Avoid race condition at shutdown by shutting downn the TPM 2.0
> devices synchronously. This eliminates the condition when the
> shutdown sequence sets chip->ops to NULL leading to the following:
> 
> [ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
> [ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
> [ 1586.603774][ T8669] __fput+0x109/0x1d
> [ 1586.608380][ T8669] task_work_run+0x7c/0x90
> [ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
> [ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1586.626068][ T8669] RIP: 0033:0x4cb4bb

An actual bug report would have been helpful.  However, from this trace
it's easy to deduce that tpm2_del_space() didn't get converted to the
get/put of the chip ops ... it's still trying to do its own half arsed
thing with tpm_chip_start() and the mutex.  So isn't a much simpler fix
simply to convert it as below?  compile tested only, but if you can
test it out I'll send a proper patch.

James

---

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 784b8b3cb903..0c0cd225046f 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip)) {
+
+	if (tpm_try_get_ops(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
-	mutex_unlock(&chip->tpm_mutex);
+
 	kfree(space->context_buf);
 	kfree(space->session_buf);
 }

