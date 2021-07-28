Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B13D9420
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhG1RO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 13:14:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:17689 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhG1ROX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 13:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627492455;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ky1P2Vzy1AMTkcNICB8wqEPQiEl057/o35c1M4qCBMo=;
    b=LF6XLJV3ivNtIM1wnsvIe7/rQmE/8p+rBiuBwm5ry3DqxXHUuZ70Ir48hF3HXrXDmS
    ow3XAXSKdjeR8mlbd2qL6DRuhe4GFq4Lcip43Uy+8nW/XRXNUcXHMLFiOo3OLiUHm1HE
    QlV+fS27XL1Hx938VGFFqowT7GuWOpsva75dN9slKej+yIINmYd/MfCV8gKdEymL9fW0
    3b5tc7DqmiNO2dp3fouQKpRGYl3HHRnY8tPJ755pS8w+TQfE7F2+ux+wtl9/WA2jTe/p
    z6rCnPIG9fqcJVVHhoMldbzfqpXdmV1ypeYQmiDwh1jtLaY10Bp+l/KD1/TeNKxyzvUJ
    qdvg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoau5J4Tj7+uA76w8eadkyoCWU/S6TOnfqgd7To/uJm/gTTBonpqa8ec="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id t06ddcx6SHEFtam
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Jul 2021 19:14:15 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     tusharsu@linux.microsoft.com
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        public@thson.de, snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Wed, 28 Jul 2021 19:14:02 +0200
Message-Id: <20210728171402.1120181-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <a30c8208-f255-d0f0-0bfb-c037367e638c@linux.microsoft.com>
References: <a30c8208-f255-d0f0-0bfb-c037367e638c@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

> Most likely this is because you haven't set CONFIG_IMA_DISABLE_HTABLE=y.
Yes, that was the case. 

With CONFIG_IMA_DISABLE_HTABLE=y the behavior is as expected. Now a new
measurement is created if I create the same device twice.

Regards,
Thore
