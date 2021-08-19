Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED03F215C
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhHSULD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 16:11:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234511AbhHSULD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 16:11:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JK3jAg067442;
        Thu, 19 Aug 2021 16:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ow831jAIK4slW1DSv+vsd/VgYNB7cLpd3HPUfHEhRwU=;
 b=dZAeIIlAiOjv/j8ZYFTmFreAFTxpnqcBFxhe9FEoaKVW45UbiQQ/1DhRfx+DTKXLDUKs
 d5PhZzjpMWQtvtvUZ24DPPSDCdQ8YJkGRAIdhkCm2ThWj4xUjyEjRIDWmhwVhVRQJYDT
 n4dTwkqvBkdL9dAc9KypkBdNCen04jXJ4L0RPBV1/IWMpqIPt4xpG1mA5lFwVGahYCXK
 1iSoeBxoX3Rc7W1c0vg2Wb1IOlNQoLPgpJOUDVodvvCiq/h7MHAC4qMooMM87Ru93qht
 WLf1mTNoaRIioXhx5K5drcqmfhCE2Uu6zLE9Unz5Gwv/k9+XehOj33kCw8uZiWAwvTuh Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ahq0yqbdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 16:10:24 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JK477F068723;
        Thu, 19 Aug 2021 16:10:24 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ahq0yqbdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 16:10:24 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JJe84v026303;
        Thu, 19 Aug 2021 20:10:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3ae53hfj4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 20:10:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JKAJ4Y53543178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 20:10:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0A94C04A;
        Thu, 19 Aug 2021 20:10:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CA444C05C;
        Thu, 19 Aug 2021 20:10:18 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 20:10:18 +0000 (GMT)
Message-ID: <05e47a86695818bfb0f1dca6aa3ea7cea6c6dffc.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 19 Aug 2021 16:10:17 -0400
In-Reply-To: <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
         <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
         <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UrYWi529eGzTYtMd_ZZML2kng-ep66_9
X-Proofpoint-GUID: hAu51Cwq01oZEYB1tSXBRoU5ExDnZMP4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_07:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 21:12 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Thu, Aug 19, 2021 at 02:06:03PM -0400, Mimi Zohar wrote:
> > On Thu, 2021-08-19 at 05:11 +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > > Change from v1:
> > > - Do not use setfbuf to disable buffering as this is not proven to be
> > >   meaningful.
> > > - Use secure heap for passwords too as suggested by Mimi Zohar.
> > > - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
> > > - Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
> > >   OpenSSL init.)
> > > - Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
> > >   get_password" patch v2.
> > 
> > Not sure why it isn't applying with/without Bruno's v2 patch.
> 
> It should be over next-testing + (manually git am'ed) Bruno's patch:
> 
>   db25fcd 2021-08-19 03:20:48 +0300 Use secure heap for private keys and passwords (Vitaly Chikunov)
>   d37ea6d 2021-08-16 12:15:59 -0300 evmctl: fix memory leak in get_password (Bruno Meneguele)
>   b1818c1 2021-08-03 16:40:08 -0400 Create alternative tpm2_pcr_read() that uses IBM TSS (Ken Goldman) (origin/next-testing)

Sorry, my mistake.  Applied the wrong patch.

Mimi


