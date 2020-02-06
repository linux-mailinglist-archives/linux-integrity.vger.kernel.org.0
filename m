Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46767154BAB
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBFTKa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 14:10:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727630AbgBFTK3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 14:10:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016J7Tke113218
        for <linux-integrity@vger.kernel.org>; Thu, 6 Feb 2020 14:10:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn4edpf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 06 Feb 2020 14:10:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Feb 2020 19:10:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 19:10:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 016JAJcU53674176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 19:10:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C811252051;
        Thu,  6 Feb 2020 19:10:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.59])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5EFF252050;
        Thu,  6 Feb 2020 19:10:18 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] ima: Implement support for uncompressed module
 appended signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Feb 2020 14:10:17 -0500
In-Reply-To: <73919AC1-E13A-4B35-B811-B0FFBC7E8644@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <20200206164226.24875-2-eric.snowberg@oracle.com>
         <1581012329.5585.439.camel@linux.ibm.com>
         <73919AC1-E13A-4B35-B811-B0FFBC7E8644@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020619-0012-0000-0000-0000038460E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020619-0013-0000-0000-000021C0CFF4
Message-Id: <1581016217.5585.449.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_03:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-06 at 12:01 -0700, Eric Snowberg wrote:
> > On Feb 6, 2020, at 11:05 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2020-02-06 at 11:42 -0500, Eric Snowberg wrote:
> >> Currently IMA can validate compressed modules containing appended
> >> signatures.  This adds the ability to also validate uncompressed
> >> modules when appraise_type=imasig|modsig.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > 
> > Your patch description in no way matches the code.
> > 
> 
> How about if I changed the description to the following:
> 
> Currently IMA can only validate compressed modules containing appended
> signatures when appraise_type=imasig|modsig.  An uncompressed module that 
> is internally signed must still be ima signed.  
> 
> Add the ability to validate the uncompress module by validating it against
> keys contained within the .builtin_trusted_keys keyring. Now when using a
> policy such as:
> 
> appraise func=MODULE_CHECK appraise_type=imasig|modsig
> 
> It will load modules containing an appended signature when either compressed
> or uncompressed.

We - Nayna and I - will be commenting on the cover letter shortly.  I
think that will help clarify the problem(s).

Mimi

