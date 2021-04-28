Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1F36D2DC
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhD1HPa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhD1HP3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 03:15:29 -0400
X-Greylist: delayed 69 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Apr 2021 00:14:43 PDT
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E5C061574;
        Wed, 28 Apr 2021 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1619594085; x=1651130085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l9eaKaAkKR85Pux4sCFUFK41gcRTkGYct4KwrCQWxYc=;
  b=AByk0VvsIxkrbnixWOeSBW4y81xJ1wQBoY8sd2LWXj/Ap5v1+uXonRuB
   6dMObIeAOeGBqD0GImoDra0ziJdWcDlIiQsgSaK7K4BGgVmASo9k441Sq
   +mRMNxOh2uNJxWoto/7Up6BAPUc+QXQhCKZGNZ6mvYDURO0kUS3vsYw9Y
   M=;
IronPort-SDR: 4sf6OteSAV6FD49hPuQvp2GBFiPKVTejBbCl2BBp9Hx8JUg3P3bTZFn6Lr36AVCsrbDff2S+Nz
 SDoDDdAN8LVtD5xE+lZvfA71NBcnVcNw0VYRyC6/3lMWjuk4/PTUVAipzUuRsTrvl8wYrZoUfc
 saF39nM5I4T6PRZ4tPmwTU/u8XhmucV+rrq0+ZbHDb+47Kkhk6rU449dHkT17MbUXIk/+vWtbC
 0FXtX4szdajLHvIRSH/EMVp0ANxzVJjxx6uvsd8HWaH/OAZttEaZ3ZLccyeGV8dz9E6oFX1xOe
 pIY=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="231035086"
X-IronPort-AV: E=Sophos;i="5.82,257,1613430000"; 
   d="scan'208";a="231035086"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 09:13:29 +0200
Received: from MUCSE718.infineon.com (MUCSE718.infineon.com [172.23.7.101])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 28 Apr 2021 09:13:28 +0200 (CEST)
Received: from MUCSE711.infineon.com (172.23.7.83) by MUCSE718.infineon.com
 (172.23.7.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2106.2; Wed, 28
 Apr 2021 09:13:28 +0200
Received: from MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5]) by
 MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5%20]) with mapi id
 15.01.2106.013; Wed, 28 Apr 2021 09:13:28 +0200
From:   <Peter.Huewe@infineon.com>
To:     <jarkko@kernel.org>, <LinoSanfilippo@gmx.de>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <stefanb@linux.vnet.ibm.com>,
        <James.Bottomley@hansenpartnership.com>, <keescook@chromium.org>,
        <jsnitsel@redhat.com>, <ml.linux@elloe.vision>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] tpm: Simplify locality handling
Thread-Topic: [PATCH v2 2/4] tpm: Simplify locality handling
Thread-Index: AQHXOi2MFFLqon71SkOYPqoVcMwIWKrI6e6AgACci5A=
Date:   Wed, 28 Apr 2021 07:13:28 +0000
Message-ID: <42097d7cc31c4cf495d1f8b46b3587af@infineon.com>
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-3-git-send-email-LinoSanfilippo@gmx.de>
 <YIii8RQR/Mcc7PKJ@kernel.org>
In-Reply-To: <YIii8RQR/Mcc7PKJ@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.8.247]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 26, 2021 at 01:47:18AM +0200, Lino Sanfilippo wrote:
> Currently the TPM (default) locality is claimed and released for each=20
> access to the TPM registers which require a claimed locality. This=20
> results in locality claim/release combos at various code places. For=20
> interrupt handling we also need such a combo in the interrupt handler=20
> (for clearing the interrupts) which makes the locality handling even=20
> more complicated since now we also have to synchronize concurrent=20
> accesses in process and in interrupt context.
>
> Since currently the driver uses only one locality anyway, avoid the=20
> increasing complexity by claiming it once at driver startup and only=20
> releasing it at driver shutdown.
>
> Due to the simplifications the functions tpm_request_locality() and
> tpm_relinquish_locality() are not needed any more an can be removed.
>

+1
I like the idea, as it also improves performance a bit.
Peter
