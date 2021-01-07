Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD202ED318
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 15:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbhAGO4g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 09:56:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbhAGO4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 09:56:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107EakcR045144;
        Thu, 7 Jan 2021 09:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nC6YpYuyHNyMmqV7VrJLBALaa1pnP1LX6Feuoxtgj2o=;
 b=rFHz+KmX7Yy2AqrrG9aCVKlB5cYtf36qDp5LUAiTc7oq66u/7C0+B/YSniX1i4kvj2NM
 8gZe+i6t1F0VA92YWn6PKMaAOEB/Uc/UtM/egtSoYwhiaWvhpPNvLV2WIKywcsZGDvOy
 THdxZB5/YR4NvKvfj1EHeZiCAT7afuurPdtfOW0lGsoBEtR7jRWi1RSSdNooT+RPr9kJ
 ppBfd05LOpVpUQZQXbvdM9V3k/nqQ8kVCDoiOq9xAaPOIoHlJ+GQXcj0kHhFIMk8h4kg
 rWMa2iYCmQKd1GvoLkNH+URwFTlgOu/Qsng5DpopwO0IDhlXYjm7sjuE+4LgdUcR4B8b 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35x391jjen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 09:55:52 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107Ee6AO061779;
        Thu, 7 Jan 2021 09:55:52 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35x391jje1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 09:55:52 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107Eqwgx013933;
        Thu, 7 Jan 2021 14:55:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 35tgf7tkcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 14:55:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107Etle622872358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 14:55:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D710AE045;
        Thu,  7 Jan 2021 14:55:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B234AE051;
        Thu,  7 Jan 2021 14:55:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.37.241])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 14:55:46 +0000 (GMT)
Message-ID: <af155b97f2df0541d45d24391d177c9c16f8713d.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] Fix sign_hash not observing the hashalgo argument
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org, pbrobinson@redhat.com
Date:   Thu, 07 Jan 2021 09:55:45 -0500
In-Reply-To: <20210107131555.t7k4r2kytftj2nip@altlinux.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
         <20210106094335.3178261-2-patrick@puiterwijk.org>
         <ed6980130453e529d5bc8a089a0d0082d2f471cd.camel@linux.ibm.com>
         <20210107130816.wmzrcx5il4hdmah6@altlinux.org>
         <20210107131555.t7k4r2kytftj2nip@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_06:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 16:15 +0300, Vitaly Chikunov wrote:
> On Thu, Jan 07, 2021 at 04:08:16PM +0300, Vitaly Chikunov wrote:
> > Patrick, Mimi,
> > 
> > On Thu, Jan 07, 2021 at 07:24:43AM -0500, Mimi Zohar wrote:
> > > On Wed, 2021-01-06 at 10:43 +0100, Patrick Uiterwijk wrote:
> > > > This fixes sign_hash not using the correct algorithm for creating the
> > > > signature, by ensuring it uses the passed in variable value.
> > > > 
> > > > Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> > > 
> > > Thank you.  This is a regression first introduced in commit
> > > 07e623b60848 ("ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API").
> > 
> > Ah, when sign_hash() is used not via evmctl, but as a library
> > imaevm_params may be not set.
> 
> Thinking about imaevm_params -- it's still belong to a library and
> extensively used in libimaevm.c, so I wonder if the fix is perfect.
> Since, now there is hash_algo and algo duplication which one to prefer
> and why?
> 
> Maybe, it should be [also] set like keypass in sign_hash?
> 
>   int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
>   {
> 	  if (keypass)
> 		  imaevm_params.keypass = keypass;
> 
> +	  if (hashalgo)
> +		  imaevm_params.hash_algo = hashalgo;
> 
> 	  return imaevm_params.x509 ?
> 		  sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
> 		  sign_hash_v1(hashalgo, hash, size, keyfile, sig);
>   }
> 
> 

As seen above, the main difference between keypass and hashalgo is that
hashalgo is being passed as an argument, while keypass isn't.  Instead
of changing the function arguments, it looks like keypass was stored as
global variable.  For this reason, the priority should be the function
argument, not the global variable.

thanks,

Mimi


