Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344933F1F28
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhHSRdo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 13:33:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhHSRdo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 13:33:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JH42Iq103525;
        Thu, 19 Aug 2021 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VaGmT9pAZx7k7u/Cg6rHBBP9jFUURlyOyNSuOvjweGc=;
 b=hbub7qrUfmZrGW0KGAWYUK5Ks6BBulE9ry0FK4J/01+ycGy/dfF+gYgLydMAZXwrd9+e
 hx9ol1VqKHwI5SmcjJMGoqBskuxcuJCCZtfcoI2EV+DMM6KK4NjENMcTbezSWvYYciUi
 TnXXhMMm+h5yMEYP/gGz5NCoWobD0gIC95G76hhge8YCP4NHIMrUgcXdrUKmLp34V5o4
 4vTwbncZN/wn4Vyaf9X8xeQ5MUpzmXWi+RbTe95BK8iyGqqOE0kr4RLI9zN6X+l+rspe
 x5jGYad7Z9e6+8e9n7aXXvmmOPWTf7kOt8Zt2/Vup2KN4Ed7YU44pyg/9u/RMZR9eNVE fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahq5ds9q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:32:46 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JH6GE7119252;
        Thu, 19 Aug 2021 13:32:45 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahq5ds9pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:32:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JHWhcc004868;
        Thu, 19 Aug 2021 17:32:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3afwrhv47k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 17:32:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JHWeul54919648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 17:32:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F89F11C058;
        Thu, 19 Aug 2021 17:32:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB7811C052;
        Thu, 19 Aug 2021 17:32:35 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 17:32:35 +0000 (GMT)
Message-ID: <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Thu, 19 Aug 2021 13:32:34 -0400
In-Reply-To: <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJAOsvngqjodT5zWjAyhG8qLCPdidYMl
X-Proofpoint-ORIG-GUID: Wy9C5Qq0n4VkNUlS1-Sz5gxuIJvv7fZE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 09:23 -0600, Eric Snowberg wrote:
> > On Aug 19, 2021, at 7:10 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
> >> On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
> >>> Downstream Linux distros try to have a single signed kernel for each
> >>> architecture.  Each end-user may use this kernel in entirely different
> >>> ways.  Some downstream kernels have chosen to always trust platform keys
> >>> within the Linux trust boundary for kernel module signing.  These
> >>> kernels have no way of using digital signature base IMA appraisal.
> >>> 
> >>> This series introduces a new Linux kernel keyring containing the Machine
> >>> Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
> >> 
> >> I would name it as ".machine" because it is more "re-usable" name, e.g.
> >> could be used for similar things as MOK. ".mok" is a bad name because
> >> it binds directly to a single piece of user space software.
> > 
> > Nayna previously said,
> >   "I believe the underlying source from where CA keys are loaded might vary 
> >   based on the architecture (".mok" is UEFI specific.). The key part is 
> >   that this new keyring should contain only CA keys which can be later 
> >   used to vouch for user keys loaded onto IMA or secondary keyring at 
> >   runtime. It would be good to have a "ca" in the name, like .xxxx-ca, 
> >   where xxxx can be machine, owner, or system. I prefer .system-ca."
> > 
> > The CA keys on the MOK db is simply the first root of trust being
> > defined, but other roots of trust are sure to follow.  For this reason,
> > I agree naming the new keyring "mok" should be avoided.
> 
> As I said previously, I’m open to renaming, I just would like to have an 
> agreement on the new name before changing everything.  The current proposed 
> names I have heard are “.machine" and ".system-ca".  Is there a preference 
> the maintainers feel is appropriate?  If so, please let me know and I’ll 
> rename it. Thanks.
> 

Jarkko, I think the emphasis should not be on "machine" from Machine
Owner Key (MOK), but on "owner".  Whereas Nayna is focusing more on the
"_ca" aspect of the name.   Perhaps consider naming it
"system_owner_ca" or something along those lines.

thanks,

Mimi


