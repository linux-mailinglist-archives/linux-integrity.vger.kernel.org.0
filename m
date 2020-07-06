Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90A2156AE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgGFLr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGFLr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 07:47:56 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jul 2020 04:47:55 PDT
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20277C061794;
        Mon,  6 Jul 2020 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1594036075; x=1625572075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EQDXlk7XMaqXKin66vyJ0DXTGrbiOpBMELrFtZOLmJE=;
  b=j+GBsSFf+hTQnRrI6PCFaYKYWLBeKJjozxQo5TQ71HjfJqaKqLBL9H1m
   MCXmglVpqs5T+QLfL5aW1pnFNzFBQu+xWD3RE4ougbF2QzWwc4Ne2G+P4
   vW5DkvDziJ0ki49foQbY/PaLZMDpiUcOZhDqoyrr50Zk/99RS9AAdNzn5
   U=;
IronPort-SDR: wIJhBVfJYbOXelU5nPj89WSh/xhvR86Dvg1D5r1IiYHBH2ZmUWU+YQyHEb0r7PD8QPj3zy7ruZ
 ZSBwymnCYficWCaCkLyc4tX543fHM1LasHZUC+GXxXFvOERbXTibFZVyOB95JixfPosA+YT+OR
 hH8yYY/R9ukADSZjpyhkndoHExwhUa3yY20j+Yg9csCuLit1dx2Fk6lsXXZh2Me01b+G6ioewG
 u2w9F6U6zVDquM6Fl30UCe7ByYp5mf3CzJUs3z7GoG+rjrwJQHvFJ7r/i+AklFHEdkusclp45e
 xZo=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="168624440"
X-IronPort-AV: E=Sophos;i="5.75,318,1589234400"; 
   d="scan'208";a="168624440"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 13:46:47 +0200
Received: from MUCSE717.infineon.com (MUCSE717.infineon.com [172.23.7.74])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  6 Jul 2020 13:46:46 +0200 (CEST)
Received: from MUCSE711.infineon.com (172.23.7.83) by MUCSE717.infineon.com
 (172.23.7.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1913.5; Mon, 6 Jul
 2020 13:46:46 +0200
Received: from MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5]) by
 MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5%20]) with mapi id
 15.01.1913.010; Mon, 6 Jul 2020 13:46:46 +0200
From:   <Peter.Huewe@infineon.com>
To:     <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC:     <kjhall@us.ibm.com>, <ferry.toth@elsinga.info>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tpm_tis: Remove the HID IFX0102
Thread-Topic: [PATCH v2] tpm_tis: Remove the HID IFX0102
Thread-Index: AQHWSpi7zu+k2ZgGwES2mspmWAztdKj6fvXg
Date:   Mon, 6 Jul 2020 11:46:46 +0000
Message-ID: <e9caad58aba44bb3abeac8569a6bd8ed@infineon.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.8.247]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
NACK

> % git --no-pager grep IFX0102 drivers/char/tpm
> drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> Obviously IFX0102 was added to the HID table for the TCG TIS driver by mi=
stake.

The HID IFX0102 was NOT added by mistake.
Let me explain the history a bit:

Old SLB 9635 / 9630 TPMs had two ways to interface them
- proprietary 'io' mapped protocol (tpm_infineon)
- tis protocol  (tpm_tis)

Both match the same HID.
However with the emerging of the tis protocol, the io protocol eventually w=
ent away for newer products.
So all TPM1.2 by IFX match the HID0102 and the TCG generic ones PNP0C31

So basically you break TPM1.2 support for all (newer) Infineon chips if the=
 platform vendor used the IFX0102 HID as they would speak via tpm_infineon =
driver.
The bug must be something different, especially as it only seems to happen =
after suspend resume.


Thanks,
Peter
