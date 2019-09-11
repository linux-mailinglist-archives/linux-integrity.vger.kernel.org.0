Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E564CAFC0A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfIKMAt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Sep 2019 08:00:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9752 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbfIKMAs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 08:00:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BBpoYe040171
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 08:00:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvehksm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 08:00:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Sep 2019 13:00:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 13:00:43 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BC0gOS34734184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 12:00:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EDAD42041;
        Wed, 11 Sep 2019 12:00:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4494042061;
        Wed, 11 Sep 2019 12:00:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.219.19])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 12:00:41 +0000 (GMT)
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Wed, 11 Sep 2019 08:00:40 -0400
In-Reply-To: <1568157876.4991.3.camel@linux.ibm.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
         <1568157876.4991.3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091112-0016-0000-0000-000002A9FD9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091112-0017-0000-0000-0000330A8992
Message-Id: <1568203240.5783.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> > Create, save and load trusted keys test
> 
> Creating trusted keys is failing with the following messages.  Any idea why?
> 
> [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> [  147.014678] trusted_key: srkseal failed (-1)
> [  147.014687] trusted_key: key_seal failed (-1)

This is a regression, that needs to be resolved.  The test works on
kernels prior to 5.1.

Mimi

