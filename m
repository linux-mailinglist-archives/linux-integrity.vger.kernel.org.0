Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B722E7C5
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0Ide (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 04:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgG0Ide (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 04:33:34 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7DC061794;
        Mon, 27 Jul 2020 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1595838814; x=1627374814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7LaxfNE64L/JQojkBYKPBox9K7OsCJ2QWRkABxmkPjM=;
  b=mFLKdcFQgQpykAkKnhK5RC8pXW/JiYfP981U2cqVj+ZcGtV4SsfZ5aGX
   HN40acsAMv55IJnT1gr15lyxvdTBL/Csk9sUFb9sbco5qCWN0baLvOiNR
   agwyfkiZKhiFFivQfCjNGnkNqMWj1QgpOoaPnOhcaAT27KRsyGiWl6fxr
   4=;
IronPort-SDR: PVi5OazAKoPZruS2kF89Nl+QuAH5Cf0zALIf9QHKU/ThpnLejm8exJ/z1MBw42vI0b3Akyc2hp
 Dq7XmJAzcboUW0eLMTyy1Tglo4RwhtBbXkZVAEUDNDUtAY+gUGx/Ctv4iv2eD6/jg1H0L8qSdi
 IyZSJF/fsH6O6nz1QAChwc6DwRRzm2YpLKKJh23670kxOyeTgk2C9HLvJ91ioYcjxh/TLVcK7U
 qmovStrYg6u0tBejJnJLCjX8XqMKKfDM6YfhmMHFnibrtgd5Vi0qsL/tVkucvNVP3gs974afN7
 qCg=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="171356427"
X-IronPort-AV: E=Sophos;i="5.75,401,1589234400"; 
   d="scan'208";a="171356427"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 10:33:28 +0200
Received: from MUCSE718.infineon.com (MUCSE718.infineon.com [172.23.7.101])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 27 Jul 2020 10:33:27 +0200 (CEST)
Received: from MUCSE701.infineon.com (172.23.7.90) by MUCSE718.infineon.com
 (172.23.7.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1913.5; Mon, 27
 Jul 2020 10:33:27 +0200
Received: from MUCSE711.infineon.com (172.23.7.83) by MUCSE701.infineon.com
 (172.23.7.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1913.5; Mon, 27
 Jul 2020 10:33:27 +0200
Received: from MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5]) by
 MUCSE711.infineon.com ([fe80::cc45:4d1a:3881:a6e5%20]) with mapi id
 15.01.1913.010; Mon, 27 Jul 2020 10:33:27 +0200
From:   <Peter.Huewe@infineon.com>
To:     <tianjia.zhang@linux.alibaba.com>, <arnd@arndb.de>
CC:     <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <christophe.ricard@gmail.com>, <Alexander.Steffen@infineon.com>
Subject: RE: [PATCH] tpm: Fix the description error of the help information in
 Kconfig
Thread-Topic: [PATCH] tpm: Fix the description error of the help information
 in Kconfig
Thread-Index: AQHWY8Enxsmh6g9s/kGoV2thptZCGaka4RQAgAAU+ICAACMGkA==
Date:   Mon, 27 Jul 2020 08:33:26 +0000
Message-ID: <09571889ac784850a6c5855f2dc0888e@infineon.com>
References: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
 <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
 <13d8ab17-5cea-3e00-ecdb-87c68d7f2a15@linux.alibaba.com>
In-Reply-To: <13d8ab17-5cea-3e00-ecdb-87c68d7f2a15@linux.alibaba.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.8.247]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksDQpPbiAyMDIwLzcvMjcgMTU6MTAsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IE9uIE1vbiwg
SnVsIDI3LCAyMDIwIGF0IDQ6NTQgQU0gVGlhbmppYSBaaGFuZyANCj4gPHRpYW5qaWEuemhhbmdA
bGludXguYWxpYmFiYS5jb20+IHdyb3RlOg0KPj4NCj4+IE9idmlvdXNseSwgdGhlIFRQTSB2ZXJz
aW9uIG51bWJlciBpbiB0aGUgaGVscCBtZXNzYWdlIGlzIHdyb25nLCB3aGljaCANCj4+IHdpbGwg
Y2F1c2UgY29uZnVzaW9uLiBUaGlzIHBhdGNoIGZpeGVzIGl0Lg0KPiANCj4gSG93IGlzIHRoaXMg
Im9idmlvdXMiPyBJIHRyaWVkIGZpbmRpbmcgdGhlIHNwZWNpZmljYXRpb24gYW5kIGNvdWxkIG5v
dCANCj4gc2VlIGFueXRoaW5nIHRvIGJhY2sgdXAgVElTIDEuMyBiZWluZyBvbmx5IHN1cHBvcnRl
ZCB3aXRoIFRQTSAxLjMsIG9yIA0KPiB0aGUgZXhpc3RlbmNlIG9mIGEgVFBNIDEuMyBzcGVjaWZp
Y2F0aW9uIGF0IGFsbC4NCj4gDQpUaGVyZSBpcyBubyBUUE0gMS4zLg0KDQpUaGVyZSBpcyBhIFRJ
UyBTcGVjaWZpY2F0aW9uIDEuMyB3aGljaCBhcHBsaWVzIHRvIFRQTTEuMiANClRoZXNlIGFyZSBk
aWZmZXJlbnQgc3BlY3MsIHdpdGggZGlmZmVyZW50IHZlcnNpb24gbnVtYmVycy4NClNvIHRoZSBm
aXggaXMgaW5jb3JyZWN0Lg0KDQpUaGFua3MsDQpQZXRlcg0K
