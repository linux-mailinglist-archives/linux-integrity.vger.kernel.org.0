Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297B333936C
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Mar 2021 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhCLQbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Mar 2021 11:31:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhCLQbX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Mar 2021 11:31:23 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CG4DQR026931;
        Fri, 12 Mar 2021 11:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version; s=pp1; bh=JnMUTBq7W8QCU9OEU3oe5ceyNi8mgtY203dCwAT6F5Y=;
 b=nlGPoE9iYWJCg8r3RSfeHnDKs2G10TU5TFVZKGyqBo9jor+ilxEOoisxONhQjlSGq1v3
 IC8UP8armVYXku7oK+dZUfZrMgFJxMOyk1YUGus1pRI47MLlp5IAGx+Qvqk6VJ0uf+0g
 DLf95VTMtxb72q62mmMK2dHQROU2PABYDC90qBYY6E4ttBTZFgEwT2evRPl4cmGmfbAD
 xINT4UUcUolnsBvVchTotezIatxP/mDPZHupoK+pc0m8IYh2xWxcA6POrr10nr3/fLGY
 a0SUra/hle9AOCbk0eJ3EVQENsnUOjJFUrRHAkbZZ1GncGVw0dIB3juO41SzMifcz/Lx FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m92rft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 11:30:47 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12CG4LVr029066;
        Fri, 12 Mar 2021 11:30:46 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m92rf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 11:30:46 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12CGMf1t014852;
        Fri, 12 Mar 2021 16:30:45 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 377r5090ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 16:30:44 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12CGUhwE23724486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 16:30:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 345E678066;
        Fri, 12 Mar 2021 16:30:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE2878064;
        Fri, 12 Mar 2021 16:30:37 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.211.242])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Mar 2021 16:30:37 +0000 (GMT)
Message-ID: <5dfe8f6b5f25cc38c8410b849aaef2c3dbed7f65.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Date:   Fri, 12 Mar 2021 08:30:36 -0800
In-Reply-To: <YEuWTet0wr5DuDy/@kernel.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
         <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
         <YEEANW+khw3nJtcQ@kernel.org>
         <CAFA6WYOxsYin8wBB_yU=S-bnqM-g5TFnTU_KXxc3wSBfx_N_6A@mail.gmail.com>
         <YEkkXbWrYBTcGXEd@kernel.org>
         <9aa3173ab46b0aa7edb8146ffd3df05c1f74207e.camel@linux.ibm.com>
         <YEuWTet0wr5DuDy/@kernel.org>
Content-Type: multipart/mixed; boundary="=-ta0eA6gTP2W+keueucj0"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--=-ta0eA6gTP2W+keueucj0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-03-12 at 18:26 +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 10, 2021 at 02:26:27PM -0800, James Bottomley wrote:
> > On Wed, 2021-03-10 at 21:56 +0200, Jarkko Sakkinen wrote:
> > [...]
> > > I also need to apply 
> > > 
> > > https://lore.kernel.org/linux-integrity/20210127190617.17564-1-James.Bottomley@HansenPartnership.com/
> > > 
> > > and I would like to do both while I'm at it.
> > > 
> > > James, there was one patch that needed fixing but I cannot find
> > > lore.kernel.org link. Can you point me to that so that we
> > > can proceed?
> > 
> > I think you mean this one observing a missing space in the commit
> > message:
> > 
> > https://lore.kernel.org/keyrings/1327393.1612972717@warthog.procyon.org.uk/
> > 
> > James
> 
> Makefile needed fixing (separate lines), and spaces where missing
> between
> commas in one file (checkpatch complained).
> 
> I digged a version from my reflog but as I noted privately it's
> missing one
> file.
> 
> Either provide that file or send a new version of the full patch set.

This is the file that got lost

James


--=-ta0eA6gTP2W+keueucj0
Content-Disposition: attachment; filename="tpm2key.asn1"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="tpm2key.asn1"; charset="UTF-8"

LS0tCi0tLSBBU04uMSBmb3IgVFBNIDIuMCBrZXlzCi0tLQoKVFBNS2V5IDo6PSBTRVFVRU5DRSB7
Cgl0eXBlCQlPQkpFQ1QgSURFTlRJRklFUiAoe3RwbTJfa2V5X3R5cGV9KSwKCWVtcHR5QXV0aAlb
MF0gRVhQTElDSVQgQk9PTEVBTiBPUFRJT05BTCwKCXBhcmVudAkJSU5URUdFUiAoe3RwbTJfa2V5
X3BhcmVudH0pLAoJcHVia2V5CQlPQ1RFVCBTVFJJTkcgKHt0cG0yX2tleV9wdWJ9KSwKCXByaXZr
ZXkJCU9DVEVUIFNUUklORyAoe3RwbTJfa2V5X3ByaXZ9KQoJfQo=


--=-ta0eA6gTP2W+keueucj0--

