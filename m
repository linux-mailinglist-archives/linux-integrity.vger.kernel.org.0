Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194D73C83ED
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhGNLfq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 07:35:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:34191 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhGNLfq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 07:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626262371;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rVhnIMns4Yw4iYT7zIPdwcOxsFidC0nZeXfDWV0u3e8=;
    b=iO8Cg//gl9+P/4/u74Qa3XwsCpZ5hQnD36fhEFihEUlplpATBQRZaXphOD9UpffEE1
    mlccyrLbaANvecXQ+OWsGQzmY+HX0sj5a9gcy2wqb4l9MZQLPcbt+Tk7rCtB3b4Qrg8H
    xeW6RyHHLEZW2elYlayUa6qe7wqZ+1SMkgLLc1zgJoCHCDsFJ+2KO5utu1zacH/lSdZi
    6a6A86YgqL11LsIGEfTJAxZ05X6u6DCV2QPRL/KAx0icxSbV+omSAJkuyD7eiPsP7sPk
    W3YXQpDrWKe2wVvKHAAq/MuNgFCVKHy5K3I9kHy2bPCDjrhqNl+O+gakRmdJdjIp3Py6
    6gzw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IW0NeWC8c+zN1nIYOgi8rPKEoKABwRR6O3/XVYQwcrYSSclzVPtV9u1ghAtu"
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id 30791cx6EBWpw99
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jul 2021 13:32:51 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     tusharsu@linux.microsoft.com
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Wed, 14 Jul 2021 13:32:41 +0200
Message-Id: <20210714113241.28580-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thank you for bringing IMA support to device mapper. The addition of dm-verity
to IMA is very useful for the project I'm working on where we boot
our distribution from removable USB media.

One of our goals is to detect tampering of the root file system remotely.
Therefore we enabled dm-verity support but implementing remote attestation for
dm-verity from userland is not ideal which was our initial plan.

This patch set enables us to leverage to already implemented IMA attestation
infrastructure by the remote attestation service that we are using (Keylime)
without trying to roll a custom solution.

We tested the initial RFC patch set and will continue testing with this one to
see if it fully works in our environment and with our use case.

Thore Sommer

