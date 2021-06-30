Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019923B872D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhF3Qlm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 12:41:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229510AbhF3Qlm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 12:41:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UG4H0p138965;
        Wed, 30 Jun 2021 12:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IpAhwd0fY0MtyP7awHsLBfOd5agd+KKtdAFMAFCFlG0=;
 b=TBBKS8X669I/Xh35/smzUcCqagMPNgtOoSmJ/qLdXxqh5jk0Nc8g789EJr3ZulhXBy6N
 RtimpreqejcYZH0aVapgWsDsI9UjB9RH19oTICiyqAttvPojMuBquvQh4IRKuooWKeik
 zK09SVh3BVDyYfXXpp2Ijfa0NcYlVdj0+zWGuEwEZVpQGIgiT2RDSIWUvssomzp7pWSv
 FMp7BRgj7VCWr4LKaIOAo1OKkzEJ89cYfksT2f0cO0+A2cVwwNfB4CbtwfxGnGEBlHFp
 KSKSVgvIxc1o6LLAdd1iKL+Hy/8lIt6vGomSyxnmN+5AKYapqLsiqD4u7eSS1Cug/Uvr +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gtxf2wfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:39:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UG5w0r151403;
        Wed, 30 Jun 2021 12:39:10 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gtxf2weu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:39:10 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UGN7FC024533;
        Wed, 30 Jun 2021 16:39:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 39ft8ere8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 16:39:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UGbTl337224898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 16:37:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2FC8A4062;
        Wed, 30 Jun 2021 16:39:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9824A407D;
        Wed, 30 Jun 2021 16:39:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.126])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 16:39:03 +0000 (GMT)
Message-ID: <2f494e1d5c2c99a4b7c0912faa4c3be3de682afc.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Wed, 30 Jun 2021 12:39:02 -0400
In-Reply-To: <20210629013201.xelhje2hmiuqybrt@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-2-vt@altlinux.org>
         <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
         <20210626004241.wkkjsbbesakszfkj@altlinux.org>
         <f2355538832153c82c866d1e779b128a9612b6cc.camel@linux.ibm.com>
         <20210629013201.xelhje2hmiuqybrt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UNHMxzkTs7KOxL8EFe_nQJbX7C7GtWv6
X-Proofpoint-ORIG-GUID: KTJBGKplsZNGj6QN2FF_uor06liNWllS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Tue, 2021-06-29 at 04:32 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Jun 28, 2021 at 04:50:42PM -0400, Mimi Zohar wrote:
> > 
> > Thank you for the detailed explanation.
> > 
> > On Sat, 2021-06-26 at 03:42 +0300, Vitaly Chikunov wrote:
> > 
> > > > Requiring the optarg value to be prefixed with "0x" would
> > > > simplify the strlen test.
> > > > (The subsequent patch wouldn't need a contrived prefix.)
> > > 
> > > (I do not understand this remark at the moment.)
> > > 
> > > Base 16 will let user pass keyid just as a string, copy-pasting from
> > > somewhere else.
> > 
> > strtoul() supports prefixing the ascii-hex string with "0x".  To
> > differentiate between a keyid and pathname, why not require the keyid
> > be prefixed with "0x", as opposed to requiring the pathname to be
> > prefixed with '@', like "--keyid @/path/to/cert.pem".
> 
> I wanted to avoid (filename vs keyid) ambiguity of the argument to
> `--keyid' - if user have file named "0x00112233" they would have hard
> time passing it to `--keyid'. But, it's impossible to have keyid string
> starting with "@". So, "@" perfectly distinguish type of `--keyid'
> argument but "0x" isn't.
> 
> Also, in some software (zip, rar) "@" is common prefix meaning value
> should be taken from the specified file. But, yes, "@" is not common
> in Unix environments. Do you want me to create separate option like
> `--keyid-from-file'?

It's highly unlikely that both the filename and pathname would be
prefixed with "0x".  Defining a new option might be a good idea. 
Possibly naming it --extract-cert-keyid,  ---cert-keyid, or --keyid-
from-cert.  

thanks,

Mimi

