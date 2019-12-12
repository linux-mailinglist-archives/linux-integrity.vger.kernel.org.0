Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1888211CFC9
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfLLO3B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 09:29:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729611AbfLLO3B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 09:29:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCESKNZ133774
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 09:29:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd2f1xs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 09:28:59 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 12 Dec 2019 14:28:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 14:28:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCEScLY59047952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 14:28:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63784A4051;
        Thu, 12 Dec 2019 14:28:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F8F6A4057;
        Thu, 12 Dec 2019 14:28:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.194.137])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 14:28:37 +0000 (GMT)
Subject: Re: [PATCH v11 0/6] KEYS: Measure keys when they are created or
 updated
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 12 Dec 2019 09:28:36 -0500
In-Reply-To: <20191211164707.4698-1-nramas@linux.microsoft.com>
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121214-0028-0000-0000-000003C7E065
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121214-0029-0000-0000-0000248B1A2E
Message-Id: <1576160916.4579.151.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Wed, 2019-12-11 at 08:47 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system are currently not measured.
> Therefore an attestation service, for instance, would not be able to
> attest whether or not the trusted keys keyring(s), for instance, contain
> only known good (trusted) keys.
> 
> IMA measures system files, command line arguments passed to kexec,
> boot aggregate, etc. It can be used to measure keys as well.
> But there is no mechanism available in the kernel for IMA to
> know when a key is created or updated.
> 
> This change aims to address measuring keys created or updated
> in the system.

Thank you!  This patch set is now queued in the next-integrity-testing 
branch of https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git/.

Mimi

