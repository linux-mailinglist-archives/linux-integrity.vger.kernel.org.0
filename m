Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD200360E46
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhDOPNU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 11:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234937AbhDOPLU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 11:11:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FF45Nx025632;
        Thu, 15 Apr 2021 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eG38sNxD2b02Y/xxfRKuCCPL6LNBdvvcoX2gkk3L76w=;
 b=BGpYCNk9dV3tH4NwgPDkCOIm5QZ3Nj4/gZJpArMTRMARoZRjUXZFilT8J1LMelUx+iI5
 xfS4iPWu9ri9UfwjDDuHkruX5uBHx9hyI/YmoMOKznbbbXq3zxOPa7SYEFCUfiZVOnhY
 OkHZFeo7Xj8qFMqQ042Scs0IUQ/rGYSHgIW4R1NmWbgJL1xJptqgnXtFTSS+uLZ3dccL
 W9YiRvnXNP+8g0lmEqYnR9NaPXt62PGPznu4CH09KRpMOdPYoWlk48iViEiIUpyL3pa0
 OdF2TR8TC1VlmGQpjossWqwiDgVxooGIkbnlZS1LY7BHgUUlCMxTwA02osuGb4GZ5/Gr kw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xfrnye3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 11:10:54 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FEuuBb027240;
        Thu, 15 Apr 2021 15:10:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 37u3n8a55t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 15:10:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FFAncB19792328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 15:10:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B7E54C050;
        Thu, 15 Apr 2021 15:10:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58CD54C044;
        Thu, 15 Apr 2021 15:10:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.14.167])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 15:10:48 +0000 (GMT)
Message-ID: <31a1d0cbc858c14b51ee33b6861fb36d3ffbde4d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] travis: Fix openSUSE Tumbleweed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 15 Apr 2021 11:10:46 -0400
In-Reply-To: <20210415112728.9307-1-pvorel@suse.cz>
References: <20210415112728.9307-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nf0b_VMPZNHHnc2WCGzyYv_YY9xqHkIT
X-Proofpoint-GUID: Nf0b_VMPZNHHnc2WCGzyYv_YY9xqHkIT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_06:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Thu, 2021-04-15 at 13:27 +0200, Petr Vorel wrote:
> openSUSE Tumbleweed build fails due broken permission detection due
> faccessat2() incompatibility in libseccomp/runc used in old docker with
> old kernel on Ubuntu Focal on hosts in Travis CI together with guests
> with the newest glibc 2.33.
> 
> Fixing Tumbleweed required switch to podman and downloading newest runc
> release (v1.0.0-rc93) which contains the fix [1], because proposed glibc
> fix [2] aren't going to merged to upstream [3] nor to Tumbleweed
> downstream glibc [4].
> 
> Sooner or later it will be required for more distros (Fedora, Debian
> Ubuntu), but don't waste build time until required.
> 
> [1] https://github.com/opencontainers/runc/pull/2750
> [2] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
> [3] https://sourceware.org/pipermail/libc-alpha/2020-November/119978.html
> [4] https://bugzilla.opensuse.org/1182451
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * remove sudo (replaced by --no-same-owner)

Thanks, Petr.  Other than actually removing the "sudo",  the patch
looks good and works properly on our internal travis too.  Assuming you
don't object, I'll remove the "sudo".

thanks,

Mimi

