Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E653BBD4FE
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbfIXWhJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 18:37:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46510 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389629AbfIXWhJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 18:37:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8E58B8EE175;
        Tue, 24 Sep 2019 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569364628;
        bh=DlP6odT+b/KwvdP5+W4aR9odr78BaW94Yj0ab8asWo8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=DMtWPHPLWfbB1BBsCAjyQq92M87oyY7XP9dT9qBx55QN7NJS+byqKQhEFpC0L54OL
         8wFoH3b0ryvNBmDWPugTiPU59QzM1JKFmcsrtPWAVU6oeY/ssdKUnwpOoRzKF7vdrw
         wfi3Hnw+leQ7lgcZIaCusFjUWkXCHwXbIVd3pBs0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bWy7E7EyBAoI; Tue, 24 Sep 2019 15:37:08 -0700 (PDT)
Received: from [192.168.101.242] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E27D28EE12C;
        Tue, 24 Sep 2019 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569364628;
        bh=DlP6odT+b/KwvdP5+W4aR9odr78BaW94Yj0ab8asWo8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=DMtWPHPLWfbB1BBsCAjyQq92M87oyY7XP9dT9qBx55QN7NJS+byqKQhEFpC0L54OL
         8wFoH3b0ryvNBmDWPugTiPU59QzM1JKFmcsrtPWAVU6oeY/ssdKUnwpOoRzKF7vdrw
         wfi3Hnw+leQ7lgcZIaCusFjUWkXCHwXbIVd3pBs0=
Message-ID: <1569364624.5364.23.camel@HansenPartnership.com>
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 24 Sep 2019 18:37:04 -0400
In-Reply-To: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-24 at 15:31 -0700, Lakshmi Ramasubramanian wrote:
[...]
> In one configuration I am testing, I see the TPM appear post IMA
> Init. Likely this is rare, but I was wondering if there was a reason
> why TPM  information is only queried during IMA init, but never
> updated at a later point.

IMA involves a chain of custody attested through the TPM.  If the TPM
isn't present on IMA init then that custody chain is broken and the
measurements can't be relied upon.  For this reason to use the TPM, it
must be present when IMA is initialized ... so the drivers all need
building in to the kernel.

There has been some discussion that we could, for UEFI systems, use the
UEFI runtime drivers for the TPM until the actual driver is inserted
but no-one's looked into doing that.

James

