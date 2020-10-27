Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F10E29BA8E
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1797452AbgJ0QGs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 12:06:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50774 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1794207AbgJ0QGj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 12:06:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RG2v23026746;
        Tue, 27 Oct 2020 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rKe7xiX9T0BHMChg7qOiI7ELlVZ2VMHGIN6AvCsC9Gw=;
 b=RlAt9RGRjmpIZAPmzyHSJ0P7n0/DPFcgXeLZ22rew95V1cVCZgLgz+50KnnSUpuiHWGg
 v1BFw5HRG7tPzLfrsY7iwAwed7Ua/oGSvsloPJl1a3rkV9DhtZR9NUCr90YrVfZbnmo2
 KkuLNl8LJmyp1zkmAuZj4avQMgjeNx1+X4EMT6sTLqEpikTP/PPdjhLCsrOo4I7g6h+d
 jEKS3pHwgCpdOdMg/YQSe3ByaMM6xJUytKV3lLA84qP53n3O3Ww23wNyungIPfGlJbyC
 YJZjal4k3wPB3yBCFSzqpxSbXrHaiXb1J6aTlEYX3nWY9pQknyS89BKdyjASmCUuakzx BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ejb6jdcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 12:06:29 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09RG32BH027196;
        Tue, 27 Oct 2020 12:06:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ejb6jdc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 12:06:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09RG4aDh022676;
        Tue, 27 Oct 2020 16:06:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34e56qrx7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 16:06:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09RG6Oul23790074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 16:06:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90F58AE055;
        Tue, 27 Oct 2020 16:06:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FBC9AE045;
        Tue, 27 Oct 2020 16:06:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.51.30])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Oct 2020 16:06:23 +0000 (GMT)
Message-ID: <26b4d298f9a71a796793f2ce730a95ebec442f29.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <petr.vorel@gmail.com>,
        Wartan Hachaturow <wart@debian.org>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue, 27 Oct 2020 12:06:22 -0400
In-Reply-To: <20201020180231.GA14580@dell5510>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
         <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
         <20201020180231.GA14580@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_08:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Wartan Hachaturow]

Hi Wartan,

On Tue, 2020-10-20 at 20:02 +0200, Petr Vorel wrote:
> > > [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA
> 
> > I wasn't aware that because of lockdown, IMA was disabled.  Thank you
> > for reporting and updating the IMA w/lockdown status.
> Feel free to comment it, please. It'd be nice to have IMA in Debian (not sure
> about Ubuntu status).
> 
> @Dmitry: do you plan to update Debian package? (you're the listed maintainer,
> although the package was signed by Wartan Hachaturow).

Earlier this year Dmitry Eremin-Solenikov posted a patch to add
libressl support to ima-evm-utils.  Part of the reason for our adding
travis support was in order to create a testing matrix for testing
openssl, libressl, ibmtss and tpm2-tss, which further led to the
travis-docker distro support.  (Due to some issues, the libressl
support was not upstreamed.)

Do you know if there are any plans on updating the ima-evm-utils
package on Debian?
 
thanks,

Mimi

