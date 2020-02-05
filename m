Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB551539D6
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2020 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBEVAm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Feb 2020 16:00:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbgBEVAl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 16:00:41 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015Kre9n119247
        for <linux-integrity@vger.kernel.org>; Wed, 5 Feb 2020 16:00:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmdp2yu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 05 Feb 2020 16:00:40 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 5 Feb 2020 21:00:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 21:00:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 015L0Xj460293240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 21:00:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BED942041;
        Wed,  5 Feb 2020 21:00:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A65834204D;
        Wed,  5 Feb 2020 21:00:32 +0000 (GMT)
Received: from dhcp-9-31-103-105.watson.ibm.com (unknown [9.31.103.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Feb 2020 21:00:32 +0000 (GMT)
Subject: Re: [PATCH v2 2/8] ima: Switch to ima_hash_algo for boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        James.Bottomley@HansenPartnership.com,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        stable@vger.kernel.org
Date:   Wed, 05 Feb 2020 16:00:32 -0500
In-Reply-To: <20200205103317.29356-3-roberto.sassu@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
         <20200205103317.29356-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020521-0016-0000-0000-000002E406B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020521-0017-0000-0000-00003346E93C
Message-Id: <1580936432.5585.309.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=3
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=843 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002050160
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2020-02-05 at 11:33 +0100, Roberto Sassu wrote:

<snip>

> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: stable@vger.kernel.org

Cc'ing stable resulted in Sasha's automated message.  If you're going
to Cc stable, then please include the stable kernel release (e.g. Cc: 
stable@vger.kernel.org # v5.3).  Also please include a "Fixes" tag.
 Normally only bug fixes are backported.

Mimi

