Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCB155E18
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 19:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGS27 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 13:28:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbgBGS26 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 13:28:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017IEPfq088929
        for <linux-integrity@vger.kernel.org>; Fri, 7 Feb 2020 13:28:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nnghyf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Feb 2020 13:28:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Feb 2020 18:28:54 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Feb 2020 18:28:49 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 017IRsvK12386652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 18:27:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECB1411C054;
        Fri,  7 Feb 2020 18:28:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B4411C050;
        Fri,  7 Feb 2020 18:28:46 +0000 (GMT)
Received: from dhcp-9-31-103-165.watson.ibm.com (unknown [9.31.103.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 18:28:46 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Feb 2020 13:28:45 -0500
In-Reply-To: <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
         <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
         <1581087096.5585.597.camel@linux.ibm.com>
         <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
         <1581097201.5585.613.camel@linux.ibm.com>
         <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020718-0016-0000-0000-000002E4BF2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020718-0017-0000-0000-00003347AA8F
Message-Id: <1581100125.5585.623.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_04:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=3 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-07 at 10:49 -0700, Eric Snowberg wrote:
> 
> > On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> >> $ insmod ./foo.ko
> >> insmod: ERROR: could not insert module ./foo.ko: Permission denied
> >> 
> >> last entry from audit log:
> >> type=INTEGRITY_DATA msg=audit(1581089373.076:83): pid=2874 uid=0
> >> auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-
> >> s0:c0.c1023 op=appraise_data cause=invalid-signature comm="insmod"
> >> name="/root/keys/modules/foo.ko" dev="dm-0" ino=10918365
> >> res=0^]UID="root" AUID=“root"
> >> 
> >> This is because modsig_verify() will be called from within
> >> ima_appraise_measurement(), 
> >> since try_modsig is true.  Then modsig_verify() will return
> >> INTEGRITY_FAIL.
> > 
> > Why is it an "invalid signature"?  For that you need to look at the
> > kernel messages.  Most likely it can't find the public key on the .ima
> > keyring to verify the signature.
> 
> It is invalid because the module has not been ima signed. 

With the IMA policy rule "appraise func=MODULE_CHECK
appraise_type=imasig|modsig", IMA first tries to verify the IMA
signature stored as an xattr and on failure then attempts to verify
the appended signatures.

The audit message above indicates that there was a signature, but the
signature validation failed.

Mimi

