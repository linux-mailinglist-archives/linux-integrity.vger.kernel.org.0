Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB623DF92D
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 03:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHDBPY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 21:15:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49624 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbhHDBPY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 21:15:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17413jga141695;
        Tue, 3 Aug 2021 21:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=r8ah1H336Sc9R6OFxwhQA4dKW5+68cyEFEVqYHZcA+Q=;
 b=XpBEMLWJR1q9TUHt+OPZsNMSF40SzILYjQ2CIALoJwXqEaJlqwJKsG7ozt8uUsL5NnaD
 VdVKNjRZy54sU9BpoMZ87j+sBdczIMZBWdze+yiSAnevMMG978t+PMh1JGfqX79ZNYjL
 KeMBLoPz0iRLz4U7RLE7Lq9RrSw2FoHTaIPhmRz3y1Gl5r+0tnR3W+cnRWzHRnMN+Ctt
 supZVp60BL2rBGO5tOL9EsJMVVsR/G5zWY/GNNQ1GXwcEilXygPuBag+t++E7b+eGoDk
 +MQNlKaaGEKZcV30DuULXnjTmSFSjlOqjFjCGnuDvH0GZPDTu+IenPKzv9iIqpHfN20d xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7b77qtex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 21:14:42 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17414edg144479;
        Tue, 3 Aug 2021 21:14:41 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7b77qted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 21:14:41 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1741C1i9021026;
        Wed, 4 Aug 2021 01:14:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3a4x597exk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 01:14:39 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1741EbKE58524022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Aug 2021 01:14:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E935611C066;
        Wed,  4 Aug 2021 01:14:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EAC811C04A;
        Wed,  4 Aug 2021 01:14:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.88.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Aug 2021 01:14:31 +0000 (GMT)
Message-ID: <5ac7f5fc866dd271ecfc9be17fef7fa47babbc6e.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Tue, 03 Aug 2021 21:14:30 -0400
In-Reply-To: <2BBC3A71-6E0D-47A2-842A-11C279A5DC56@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
         <2BBC3A71-6E0D-47A2-842A-11C279A5DC56@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M65tFsTH8Ok_ikX9zRsX1_tTg9e0oufs
X-Proofpoint-ORIG-GUID: 73SCjQ_TXsQIP2QZf6QHBmhyZVWpWxSC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_08:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Tue, 2021-08-03 at 13:52 -0600, Eric Snowberg wrote:
> > On Aug 3, 2021, at 11:01 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:
> > 
> >> When the kernel boots, if MokListTrustedRT is set and
> >> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
> >> mok keyring instead of the platform keyring. Mimi has suggested that
> >> only CA keys or keys that can be vouched for by other kernel keys be
> >> loaded into this keyring. All other certs will load into the platform
> >> keyring instead.
> > 
> > I suggested only loading the CA keys stored in the MOK db onto the MOK
> > keyring.  Like the builtin trusted keyring, the MOK keyring would also
> > be linked to the secondary keyring.   Assuming the secondary keyring is
> > defined, all other properly signed MOK db keys  - signed by keys on the
> > builtin, secondary or MOK keyring - would be loaded onto the secondary
> > keyring.
> > 
> > As previously discussed, this might require reading the MOK db twice -
> > once to load the CA keys on the MOK keyring, a second time to load the
> > remaining properly signed keys onto the secondary keyring.
> 
> I’m only loading CA keys or keys that can be vouched for by other kernel 
> keys into the new mok keyring.

The cover letter implies that this suggestion is coming from me, which
it definitely is not.  My preference, as I made clear from the very
beginning, is to load ONLY the MOK DB CA keys onto the mok
keyring.   (And even go one step farther, requiring the MOK DB CA
key(s) to be identified on the boot command line.)

> Currently, I’m not doing another pass.  I 
> could add another pass, but it would not solve the issue with someone trying 
> to load an intermediate CA along with a leaf cert.  This would require yet 
> a third pass.  I wasn’t sure if this added complexity was necessary.  
> 
> Currently, any CA contained within the MOK db would now be trusted by the 
> kernel.  Someone using a kernel with the secondary keyring enabled could 
> load the intermediate and leaf certs themselves following boot.

Correct, as previously discussed, the other signed MOK DB keys may be
loaded by userspace.   The only reason we're interested in any of the
other MOK DB keys is prevent a regression.  As you previously pointed
out all of the MOK DB keys are currently being loaded onto the platform
keyring.  So leave the existing code, which loads the MOK DB keys onto
the platform keyring, alone to prevent that regression.  It's already
being controlled by a UEFI variable.

> Taking 
> this into account, if you’d like to see two passes, let me know and I’ll add 
> that in v3.  If a second pass is done, do you really want these additional 
> keys added to the secondary keyring or should they go into the mok keyring
> instead?  I was under the impression the secondary should be empty until a
> user adds their own keys into it. Thanks.

Again, my preference would be to load ONLY the MOK DB CA keys onto the
mok keyring.

If YOU decide you want to load the signed keys stored in MOK DB, be my
guest.  However, they should be loaded onto the secondary keyring and a
new restriction defined, similar to
"restrict_link_by_builtin_and_secondary_trusted", which includes mok as
well.

thanks,

Mimi

