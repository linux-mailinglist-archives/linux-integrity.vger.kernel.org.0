Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED629C858
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 20:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829396AbgJ0THP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 15:07:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52608 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2902408AbgJ0THP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 15:07:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RJ2BPf095690;
        Tue, 27 Oct 2020 15:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wrqPoi6ZU2Fj+Hc8kvhewdQN8S6Jr8BOn32nnAT4PTY=;
 b=YH94LE4DeC5gnvRwWNwHKCUTOENYCK0h7t10DnCpvhMvUUmW42uVZydFwbiuYiGySeLj
 rbEpOLUO67xbB/BU4omROdS3ZbaRMQ9rTTz2K58V3sqN+J320jaysZACEMoA7Bs2DLGI
 vOtMWFMupnNMkc0TwBcUZDA/TKqURMK4O4l4pcYwfDLqk1dkw7DAqWEiAJkxPTXALjtm
 4VvUi9G4rCoVHkeWIldbWGhhlzIzRO7y8TSumlRWqg0uGf8b8DipGQlkKQT72g8Avrc0
 kvqPKwvZSbovDt4dk0/jnVL9Eo11WJio7ykQ25BzDXsb9y1Uf8w2KYn/srCjH3iAxkus OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ekqddkex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 15:06:59 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09RJ3BjI100857;
        Tue, 27 Oct 2020 15:06:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ekqddke2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 15:06:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09RIqo89007295;
        Tue, 27 Oct 2020 19:06:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 34cbhh3pan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 19:06:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09RJ6t2T30015994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 19:06:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB6CAE055;
        Tue, 27 Oct 2020 19:06:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9C3EAE04D;
        Tue, 27 Oct 2020 19:06:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.14.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Oct 2020 19:06:53 +0000 (GMT)
Message-ID: <6d213e5decd0bf1290ae37e2da353aae504f2581.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        Petr Vorel <petr.vorel@gmail.com>,
        Wartan Hachaturow <wart@debian.org>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue, 27 Oct 2020 15:06:52 -0400
In-Reply-To: <d0d1ad6c-5569-486c-3131-9b4845bd6495@rosalinux.ru>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
         <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
         <20201020180231.GA14580@dell5510>
         <26b4d298f9a71a796793f2ce730a95ebec442f29.camel@linux.ibm.com>
         <d0d1ad6c-5569-486c-3131-9b4845bd6495@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-27 at 21:51 +0300, Mikhail Novosyolov wrote:
> Hello,
> 
> 27.10.2020 19:06, Mimi Zohar пишет:
> > [Cc'ing Wartan Hachaturow]
> >
> > Hi Wartan,
> >
> > On Tue, 2020-10-20 at 20:02 +0200, Petr Vorel wrote:
> >>>> [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA
> >>> I wasn't aware that because of lockdown, IMA was disabled.  Thank you
> >>> for reporting and updating the IMA w/lockdown status.
> >> Feel free to comment it, please. It'd be nice to have IMA in Debian (not sure
> >> about Ubuntu status).
> >>
> >> @Dmitry: do you plan to update Debian package? (you're the listed maintainer,
> >> although the package was signed by Wartan Hachaturow).
> > Earlier this year Dmitry Eremin-Solenikov posted a patch to add
> > libressl support to ima-evm-utils.  Part of the reason for our adding
> > travis support was in order to create a testing matrix for testing
> > openssl, libressl, ibmtss and tpm2-tss, which further led to the
> > travis-docker distro support.  (Due to some issues, the libressl
> > support was not upstreamed.)
> 
> Mimi, it was me who posted patch for LibreSSL ("[PATCH] ima-evm-
> utils: Fix compatibility with LibreSSL"), but unfortunately I did not
> have enough time to finish it properly (I am very sorry...).
> 
> I was just going to try a newer version of ima-evm-utils and, if
> possible, continue upstreamizing support of LibreSSL. also, a
> colleague of mine made an additional patch which requires separate
> upstreamization. Was there another patch from Dmitry about which I do
> not know

Mikhail, my mistake.  Thank you for the correction!   Testing the
libressl changes should be a lot easier now.  Please remember to
include a distro travis.yml example.

thanks,

Mimi

