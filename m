Return-Path: <linux-integrity+bounces-1788-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958087F7C3
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 07:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C841F218A7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5150251;
	Tue, 19 Mar 2024 06:49:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78A50249
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830964; cv=none; b=nUH/hjk0tjkAOQ7q1PIx/bX1burME8pPQg+PvZftVbWBQfBYWANO/Vp2F/x6Dmpb0U18P08uXwpmpKxHAI+a5l8BOVtLTGvbUQ9t29hxk5Z8aaJbO+EQk9G1Zv5b7bvmj96b0Sf+5Kl8BGX20kuT2KbZEsNIgREByq9A21vL5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830964; c=relaxed/simple;
	bh=A/4zsCcztGRjqywSwkKQcNQ1/JNzCdHpOVNKMzbLfAk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYnlzDNq02+REsWkYm7VT5R/+TSu49jRFIZkdCjSgYtcMg7NdIPwAHKo9nyJGQlJuwxDDKRqyPSv/Wy/jlSTaPEZWUmGyJ8dwRXnZdP+2cDLlPrXDwsxO4bkGInVhi7i31Ob9Cc1RC+vffcMTyW7nRleLdSMqUIgoInPC03pKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 09:49:15 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 19 Mar 2024 09:49:15 +0300
From: Alberto Mardegan <a.mardegan@omp.ru>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "Dmitry
 Eremin-Solenikov" <dbaryshkov@gmail.com>, Eric Biggers <ebiggers@google.com>,
	Patrick Ohly <patrick.ohly@intel.com>, Patrick Uiterwijk
	<patrick@puiterwijk.org>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Matthew Garrett <mjg59@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
Thread-Topic: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Thread-Index: AQHaeUsBNl4WhqG93063Xa7HqarJoLE+bjsA
Date: Tue, 19 Mar 2024 06:49:15 +0000
Message-ID: <d4ef76cf-a596-4e6b-896f-e365abb5b025@omp.ru>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
In-Reply-To: <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/19/2024 3:59:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7D0E24B4AB6124C86314FB27237C0F6@omp.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMTguMDMuMjAyNCAxODo0MiwgRG1pdHJ5IEthc2F0a2luIHdyb3RlOg0KWy4uLl0NCj4+IFRv
IGFkZHJlc3MgdGhpcyBpc3N1ZSwgY2hhbmdlIHRoZSBwcm9qZWN0IGxpY2Vuc2UgdG8gR1BMLTIu
MC1vci1sYXRlcg0KPj4gYW5kIGxpYmltYWV2bSB0byBMR1BMIDIuMCBvciBsYXRlci4NCkFja2Vk
LWJ5OiBBbGJlcnRvIE1hcmRlZ2FuIDxhLm1hcmRlZ2FuQG9tcC5ydT4NCg0KLS0gDQrQoSDRg9Cy
0LDQttC10L3QuNC10LwsDQogICAg0JDQu9GM0LHQtdGA0YLQviDQnNCw0YDQtNC10LPQsNC9DQoN
CtCS0LXQtNGD0YnQuNC5INGA0LDQt9GA0LDQsdC+0YLRh9C40LoNCmh0dHBzOi8vYXVyb3Jhb3Mu
cnUv

