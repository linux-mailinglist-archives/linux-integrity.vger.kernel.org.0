Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391DA1E2F38
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbgEZTjk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389382AbgEZTjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:39:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DAC03E96D;
        Tue, 26 May 2020 12:39:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so10555085pgm.0;
        Tue, 26 May 2020 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P1S/jJWjfuAnrLOcm+BjO/Ac53iAJs4aKRGes1JuJOQ=;
        b=bdChZ6x5vP4WGqb/pLthvuv4yhSeP3uHUJoeY8eZchxnVrHzFKs1XM9otGP3DrUXt7
         gIgFsfZ/fZMYAYpSerFf4Y5HN3EpwAyNm4GDN5vUpsU7UOILV0bAB4k5tLNKRW/6ZUsp
         F4CFwRI1uMome8fNI9Mzx5Swqnly3HpOVBXJu6zknAKuJzaRvBE+CxsIEywzfkKdPBRD
         z5mhvn0b3PTeMPFldXQw3Oy/nbAhixN11mSqMMetv6oxPjzzg4bxfkA/EMuxYqegEnUa
         hsTyteUmmFvLqwMYhNyar66RSfYmVeiGT9QsfPTDnffO/yROVUByeiJsDZeMtt29ucHe
         56pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1S/jJWjfuAnrLOcm+BjO/Ac53iAJs4aKRGes1JuJOQ=;
        b=R4ZnqoLgBAxtCSL9wcvdIPVq/Z1tMk1YA8R0uEaF0haTIpj4McvEPzL88lEZQVpzJ2
         OEAhMfghovQizAnbkfGrBchlSVMUmM3mlbxdDa9kX5IIkmiwI+WBiYrWqQjZ9OigAVQ/
         gbFr4PGv3tntcqLTODA2wdzl2dAEeTkys5yAwoGnV7ncbElPv/UXUVvWiKexc0gv7RF/
         3vFpOGhHh/oZUs2WLdGGDC7LiabmNJ4LqJlVCKR3LA7Xjl1cr6HX6tAcGlOTYNAHDBfq
         CD7C/rwr6YRxh5VB/KyhbzFxxydibdPspdq5F+DzzXA9NO8BKskyydMPEtCz4B8bj4On
         Ft6g==
X-Gm-Message-State: AOAM531t3SmUsEJZRcAxW+5tXOzwbb7xJ2n52P013O/RYvdRHMSsb5LV
        OR1eB/1PT0XsylGv1ll8tQs=
X-Google-Smtp-Source: ABdhPJykdTdNMsCELn+zIRMoBr9UDlp1E8q53qGWqxtvYj9CWtZOTVW85D0Vxj3wfqCtFjshTakNJg==
X-Received: by 2002:a65:67d3:: with SMTP id b19mr430032pgs.431.1590521978781;
        Tue, 26 May 2020 12:39:38 -0700 (PDT)
Received: from [192.168.1.5] ([75.164.7.205])
        by smtp.gmail.com with ESMTPSA id gv4sm245687pjb.6.2020.05.26.12.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 12:39:38 -0700 (PDT)
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
From:   Tadeusz Struk <tstruk@gmail.com>
Message-ID: <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
Date:   Tue, 26 May 2020 12:39:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590520454.11810.40.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/26/20 12:14 PM, James Bottomley wrote:
> +	/* atomic tpm command send and result receive. We only hold the ops
> +	 * lock during this period so that the tpm can be unregistered even if
> +	 * the char dev is held open.
> +	 */
> +	if (tpm_try_get_ops(priv->chip)) {
> +		ret = -EPIPE;
> +		goto out;
> +	}
> +
Hi James,
This won't help if the message is read by an async tcti. If the problem lies
in the chip get locality code, perhaps this could help to debug the root-cause
instead of masking it out in the upper layer code:

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 2435216bd10a..da5ecd0376bf 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -202,20 +202,22 @@ static int request_locality(struct tpm_chip *chip, int l)
 		return rc;
 
 	stop = jiffies + chip->timeout_a;
+	timeout = stop - jiffies;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -1;
+			goto out;
+
 		rc = wait_event_interruptible_timeout(priv->int_queue,
-						      (check_locality
-						       (chip, l)),
+						      check_locality(chip, l),
 						      timeout);
 		if (rc > 0)
 			return l;
 		if (rc == -ERESTARTSYS && freezing(current)) {
 			clear_thread_flag(TIF_SIGPENDING);
+			timeout = stop - jiffies;
 			goto again;
 		}
 	} else {
@@ -226,6 +228,10 @@ static int request_locality(struct tpm_chip *chip, int l)
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
+out:
+	dev_warn(&chip->dev, "%s: failed to request locality %d after %lu ms\n",
+			 __func__, l, timeout * HZ / 1000);
+
 	return -1;
 }
 
