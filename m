Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAD26CDA7
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Sep 2020 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIPVDH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Sep 2020 17:03:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgIPQPE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GG1wO1023944;
        Wed, 16 Sep 2020 12:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HP4yZlq52JSVWPrTLzkNCcxKiqvvHrgoi02QnEzI7Uc=;
 b=PgRGQyZWtUG3G0tNTDe7d6ISguA6J2p2alTdxHfMoZrqKehGQ+ZLKeXyy8CNKHIqMp5o
 igoNiRGR3NqSO4vpvoe+3tkqwy1mG6UJ0szMYr3UT2P8G5ddh5E1P4tbrCpOTeyEV4Tu
 sznJNmH4ZSyXD7ddKfWVmAEuZMGoz7g9ITezlWUEXl/uFjXjs+hHVVlWpdNatjXOkJeF
 MoxQWNTLJSMpXmusuVVjCbXUHi+xULHPPSCVlUnyfQ7f26n1sgiHSU2C7tItU764/VFt
 9wawM2oHCTJHRhd797opCl4lFqxxX36fzw/OKyPUi3p8WNfhOlBTHDQU45xs5Z7ZP0U2 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33knrk8mwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:14:56 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GG2PNH026983;
        Wed, 16 Sep 2020 12:14:56 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33knrk8mw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:14:56 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GFvBsn030698;
        Wed, 16 Sep 2020 16:14:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 33k64s8e5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 16:14:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GGEqxk32178510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 16:14:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F224C04A;
        Wed, 16 Sep 2020 16:14:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C1D84C040;
        Wed, 16 Sep 2020 16:14:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Sep 2020 16:14:50 +0000 (GMT)
Message-ID: <681455532936011e3dc5e0050fddc2c3a3a7fc3c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/12] IMA/EVM fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Wed, 16 Sep 2020 12:14:49 -0400
In-Reply-To: <20200904092339.19598-1-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Fri, 2020-09-04 at 11:23 +0200, Roberto Sassu wrote:
> This patch set includes various fixes for IMA and EVM.
> 
> Patches 1-3 are trivial fixes. 

I've queued these patches in the next-integrity-testing branch for now.
When reposting this patch set please replace the cover letter subject
line with a more appropriate one.

> The remaining improve support and usability
> of EVM portable signatures. In particular patch 4 allows EVM to be used
> without an HMAC key.

EVM already supports using EVM portable and immutable sigatures without
an HMAC key.   

I was able to apply this patch set, but patch 10/12 does not apply
cleanly due to the "fallthrough" line.  Please hold off on reposting,
until I've finished reviewing the entire patch set.

thanks,

Mimi

