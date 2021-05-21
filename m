Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028E638CC34
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhEURd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 13:33:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58102 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233220AbhEURdZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 13:33:25 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LH47Iv033808;
        Fri, 21 May 2021 13:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L5aXyblV4MweJE7kliRjqe7BHKoS8cOQrVYDSV0UtSs=;
 b=n1/9CKvD0UU+OSGRXsf782Sb1jT//72bWMwiZ12djVIIYNjSu60Gi9qKbDE6HM1MweP6
 8xwoSyuE9i9lKdK0Qe7hiBk0x+/F6K0OhP0XLBJwcjC1BHhu3uebKhoVESde/3dVtKsD
 fNnJAbV7ZCPERQXNvNWT+a30suHPYL55uLLts0xk13uau7+3GZBD4fZcYQVVT60SNThs
 nGVGXSwOWK/MjnlKuuhiUsi5lhhxFEPK02ls1QYpqW8Vh7qoSGdYjjuJR28/tgjrsiX0
 NwwapRaRM/9+Oq3yzZZlyOMlPzTjI3ZSfjYL5DZHgQfdD5FGgtLJeNbil3dU/B46bNTT Wg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pgwv0p9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 13:31:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LHSHXa006975;
        Fri, 21 May 2021 17:31:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38j5x8b96s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 17:31:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LHVm9933227098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:31:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CC811C058;
        Fri, 21 May 2021 17:31:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1319F11C04C;
        Fri, 21 May 2021 17:31:47 +0000 (GMT)
Received: from sig-9-65-215-195.ibm.com (unknown [9.65.215.195])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 17:31:46 +0000 (GMT)
Message-ID: <7a52753c709499edbdf755abcd55a4ddf98503f1.camel@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] evm: Improve usability of portable signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 21 May 2021 13:31:46 -0400
In-Reply-To: <a316bc5ec316446c8b07134c33b06d77@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
         <2804f10fa77b58b4992f56ea36a36d4f1e3f4b24.camel@linux.ibm.com>
         <a316bc5ec316446c8b07134c33b06d77@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 59QOAR-obJ1YIk9sNTw3UuSxgGTKQjfG
X-Proofpoint-GUID: 59QOAR-obJ1YIk9sNTw3UuSxgGTKQjfG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_07:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-21 at 07:07 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Thursday, May 20, 2021 8:56 PM
> > On Fri, 2021-05-14 at 17:27 +0200, Roberto Sassu wrote:
> > > EVM portable signatures are particularly suitable for the protection of
> > > metadata of immutable files where metadata is signed by a software vendor.
> > > They can be used for example in conjunction with an IMA policy that
> > > appraises only executed and memory mapped files.
> > >
> > > However, until now portable signatures can be properly installed only if
> > > the EVM_ALLOW_METADATA_WRITES initialization flag is also set, which
> > > disables metadata verification until an HMAC key is loaded. This will cause
> > > metadata writes to be allowed even in the situations where they shouldn't
> > > (metadata protected by a portable signature is immutable).
> > >
> > > The main reason why setting the flag is necessary is that the operations
> > > necessary to install portable signatures and protected metadata would be
> > > otherwise denied, despite being legitimate, due to the fact that the
> > > decision logic has to avoid an unsafe recalculation of the HMAC that would
> > > make the unsuccessfully verified metadata valid. However, the decision
> > > logic is too coarse, and does not fully take into account all the possible
> > > situations where metadata operations could be allowed.
> > >
> > > For example, if the HMAC key is not loaded and it cannot be loaded in the
> > > future due the EVM_SETUP_COMPLETE flag being set, it wouldn't be a
> > problem
> > > to allow metadata operations, as they wouldn't result in an HMAC being
> > > recalculated.
> > >
> > > This patch set extends the decision logic and adds the necessary exceptions
> > > to use portable signatures without turning off metadata verification and
> > > deprecates the EVM_ALLOW_METADATA_WRITES flag.
> > 
> > Thanks, Roberto.
> > 
> > Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> > integrity.git
> > next-integrity-testing
> 
> Hi Mimi
> 
> could you please take the newer version of patch 5/12, which also adds
> an exception for the INTEGRITY_UNKNOWN error (it occurs when xattrs
> are not supported)?

Thank you for catching it.  I'd appreciate your checking once more. 
FYI, get-lore-mbox.py moved "Cc: stable" to the end.

thanks,

Mimi

