Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EB27A72F
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1GDu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 02:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1GDt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 02:03:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F20C0613CE
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 23:03:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so8361732pfp.11
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uNIIwJypljaMLPF8081AsThwTR6qY/Xcan83ZMzBJXg=;
        b=CzB6wLd5ehuADwT4jpgjVK67RwY8iSEq0mMe1A04kzKNu+rcPnPH4yVVeCb7WmgHaQ
         cv6owKlvRN9n2JXLi1/9cvNvWddOMFRhX6gesug+WVXs20gOoMY7aNxZ7cw9zY8/OPL8
         1yk2yIViPtyHm42G7b2l0BDPrdVBY8TdGX03k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uNIIwJypljaMLPF8081AsThwTR6qY/Xcan83ZMzBJXg=;
        b=nF8BxmNHV8HcnbcGhpzTAm3/yC1fQyIbJGW80a6O/YVfr5dwQ17Y0Zu7QIHG112+DC
         1arFqvSdUzzLwHyo2mZQcT+eQyJ3uDGl6W8PtoCJAISHOygWzR2P+5fvrsTK1AAZ1Eij
         IIMJmRwW6khNZMZhay9yz/c8D7vz41qP/pz79I3jkFCPhoE/mIriEwbNB3L1tAJ9tQRh
         nwnSoIcIFq+YBs8q2bn7hO8YKOm7/2bVEt0/X5i0OESV5YQzwpjsco/haDfqYw/py3iL
         NEcYETHG/R2uuxFkGOAcN4bAGy35mBqUrL20ReNhlNZ8xJ8UA3EAxKPLNS+L7IU7kVmx
         FLRA==
X-Gm-Message-State: AOAM531eAQqCz3v/Mx2qpJ/VO2eUSydKugvY6p09BabeUnxJu9yq7F7q
        k2lZEmlqx+cicdhqIXXBtLDCrQ==
X-Google-Smtp-Source: ABdhPJx8lr7qcPFdA0vzZZnZwTVpaj582wQazPcANUcYqPtEkhF2cYkqWxcKDngXPIMaX9WfpTsiEg==
X-Received: by 2002:a62:7511:0:b029:142:2501:35da with SMTP id q17-20020a6275110000b0290142250135damr124703pfc.58.1601273029095;
        Sun, 27 Sep 2020 23:03:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id cf7sm5761492pjb.52.2020.09.27.23.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:03:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20200928010835.GD6704@linux.intel.com>
Date:   Sun, 27 Sep 2020 23:03:47 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

Just to be clear it is not caused by that single commit, but a few =
accumulated commits
=
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
=
https://github.com/torvalds/linux/commit/cf151a9a44d52a63332e8e926234574fe=
5a5d784
=
https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b=
871811b
=
https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6=
a328f00

The easy way is probably just apply the patch I provided, and then =
revisit the value
for TPM_TIMEOUT_WAIT_STAT =20

Thanks
Hao

>=20
> I think I should revert 424eaf910c329, up until more legit values are =
found.
>=20
> /Jarkko

