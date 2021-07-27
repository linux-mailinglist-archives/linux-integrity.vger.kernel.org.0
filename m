Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B63D7310
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhG0KYs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:24:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:34274 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhG0KYb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:24:31 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 06:24:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627381091;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zh4kX0yAPRzCE9zcCAKrxwBLTAvbgRFm+3P/YY10Smg=;
    b=RDF2MvI7zhB5So3w8xtU6UlC6MUHAiySi4JEbNHfCg2COIdUWs2OLtdk8kjfch6123
    JJoLgFfZZPKKyo+qVRcw+GJHLjHHesd3b6vdiMIgLobp2ZMsTuxYFd3Q1I8lf9MC3QZc
    mvXNYSjLIgcLwiHfX5HoNgD96etQ+f4GZpKvumN38sQ+wucaB18t438UUUnAlbFnPqHJ
    6wL+SHhiIMxh4kOdMnf5nKV7gZBPncYW2FVnKqN061PcFFG+P3kaXu1qV1UkdGUlPabN
    R8oxeKGMrjGF+1PzJXXsY/Oi911bwPSiFCuI0J3mEp1Du8HdOHukXD/MBeE7aTN4003F
    BC2w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id t06ddcx6RAIAo5V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 27 Jul 2021 12:18:10 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     tusharsu@linux.microsoft.com
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        public@thson.de, snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Tue, 27 Jul 2021 12:18:02 +0200
Message-Id: <20210727101802.779067-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
References: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Tushar,

I've now tested your patches more in depth. I've used the latest changes from
the dm-5.15 branch. Here are some things that I noticed during testing with
dm-verity. I'm relative new to IMA and device mapper, so there are also some
more general questions.

No new IMA measurement is generated if dm-verity verification fails. This is
unfortunate because to make the dm-verity measurements useful we need to be
notified when hash_failed is set to true. We will need something like
"device_update" where we remeasure the device state if it has changed.

Creating a dm-verity device with mount then removing it and now if you create it
again no measurement is generated. Is that the expected behavior?  
I would expect that new measurements for "table_load" and "device_resume" are
created even if the entries are identical the other ones before.

There is no way to verify if the root hash was verified against a signature. We
have "root_hash_sig_key_desc SIGNATURE_DESCRIPTION" in the dm table.
"SIGNATURE_DESCRIPTION" itself is not really useful because it seems that we
cannot map it back to the certificate that was used for verification but the
presence of "root_hash_sig_key_desc" might be enough in combination with
measuring the keyring.

Is there a reason that suspend is not measured?

How is the measured uuid created? The format seems to be
"CRYPT-VERITY-UUID-NAME" where UUID is uuid from the verity device and NAME is
the device mapper name. Does this naming come from the kernel or libcryptsetup?

What can happen in between a "table_load" and "device_resume" that is security
relevant?

For remote attestation services it would be nice if we have clear indicator from
what component the "ima-buf" entry was generated. Prefixing all "n-ng" field
entries with something like "dm_" would make it easier for us to add different
validators for different measurements that use the "ima-buf" template. The
keyring measurements already use "ima-buf" and using some kind of naming scheme
to easily differentiate the entries would be nice.

Not directly device mapper related, but it would be nice to also measure the
mount points and a mapping to the device IDs. The reasoning is that we can
measure if the target is correct but not if it was mounted correctly.  
In our case we can verify the trust of our initramfs that creates the dm-verity
device and then mounts it and if this fails refuses to boot, but that might not
always be the case.

Regards, 
Thore
