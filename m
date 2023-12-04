Return-Path: <linux-integrity+bounces-341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FC803613
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 15:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B922810E4
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836A28387;
	Mon,  4 Dec 2023 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzZhE9hN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01579FE;
	Mon,  4 Dec 2023 06:10:16 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4E2dJm026034;
	Mon, 4 Dec 2023 14:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iwrWCaae83CF22C+BhZOa1m5oXHQvpDD3iPVQ/YgPhE=;
 b=QzZhE9hNFHo3uxii+5aRwWAqNEepw/LD1IkCW9Aw95+SuACbWNagXn5hPAkLZU7pKueO
 g3je5Tf5pHLWB3NnfS0qYzNnDdfOLI+yoJW+B0zbPzRCLcTdxGeA0Wq4KNPIkZzIz9Yf
 7N3DNfXAYq8SnTzta3JqD2sUXpXoqlgyk1LGSZXT8LzPKtMVpusTTAfX2izK+U488cp/
 4q6ed/ZOrOm685JV6Y0J6HngA1YftsB1XduBoB1vakOnBaizsCyZZuM1Wufs85G/SYN4
 Ujlx+QS8maGwjXGl7qoV2zmMkN90C3D5W9EEeFz2ms0H7F5C7hzEn93m0rZOUnDkopHx Mw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usg6708a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 14:10:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4E4OH4032258;
	Mon, 4 Dec 2023 14:10:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8awa1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 14:10:12 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4EABDv13763250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 14:10:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6E3D58059;
	Mon,  4 Dec 2023 14:10:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5414258043;
	Mon,  4 Dec 2023 14:10:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.81.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 14:10:11 +0000 (GMT)
Message-ID: <1ff17f0fde30e7152a630da11480a980d515f1d7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen
	 <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 09:10:10 -0500
In-Reply-To: <95222bc8dfe97bc85bcf0c022920bdce659d10fd.camel@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
	 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
	 <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
	 <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
	 <113aa55fcdd8167e6cd87b88f0beeef743bc740e.camel@linux.ibm.com>
	 <95222bc8dfe97bc85bcf0c022920bdce659d10fd.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0XBGU841uoqWHpH1t-oQs5p7pmAXA8oU
X-Proofpoint-GUID: 0XBGU841uoqWHpH1t-oQs5p7pmAXA8oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxlogscore=832 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040106

On Mon, 2023-12-04 at 09:02 -0500, James Bottomley wrote:
> On Mon, 2023-12-04 at 08:59 -0500, Mimi Zohar wrote:
> > On Mon, 2023-12-04 at 08:53 -0500, James Bottomley wrote:
> > > On Mon, 2023-12-04 at 08:43 -0500, Mimi Zohar wrote:
> [...]
> > > > Is there a way of not degrading IMA performance without disabling
> > > > HMAC encryption/decryption?
> > > 
> > > Well, perhaps we should measure it.  My operating assumption, since
> > > extend is a simple hash, is that most of the latency of extend is
> > > actually in the LPC (or i2c or whatever) bus round trip.  To do
> > > HMAC, you have to have a session, which adds an extra command and
> > > thus doubles the round trip.
> > 
> > Agreed getting some statistics would be beneficial.  Instead of
> > creating a session for each IMA extend, would it be possible to
> > estable a session once and re-use it?
> 
> Not really.  Sessions are fairly cheap to establish, so there's not
> much work the TPM has to do, so context save/restore would still have
> the same doubling of the bus round trip.  Keeping a session permanently
> in the TPM would avoid the second round trip but be visible to all the
> users and highly undesirable (would impact the number of sessions they
> could create).

Ignoring the "highly undersirable" aspsect, is there a way of limiting
visibility (and of course usage) of the "session permanently in the
TPM" to just IMA?

Mimi



