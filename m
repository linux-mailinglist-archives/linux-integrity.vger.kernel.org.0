Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C830EAFE6
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfJaMLf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 08:11:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbfJaMLf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 08:11:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VC4tMT064161
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:11:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyv89xrgj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:11:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 12:11:06 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 12:11:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VCB1px35651762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 12:11:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 797E35205A;
        Thu, 31 Oct 2019 12:11:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.194.174])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3436452050;
        Thu, 31 Oct 2019 12:11:00 +0000 (GMT)
Subject: Re: [PATCH v3 4/9] KEYS: Updated IMA policy functions for handling
 key measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Date:   Thu, 31 Oct 2019 08:10:59 -0400
In-Reply-To: <20191031011910.2574-5-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19103112-0016-0000-0000-000002BF7A31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103112-0017-0000-0000-00003320DD8A
Message-Id: <1572523859.5028.46.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support for "keyring=".  The patch title should
reflect it.

On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> Information regarding what keyrings need to be measured is missing.
> 
> A new field in the IMA policy, namely, keyrings is added to
> convey what keyrings need to be measured.
> 
> This patch updates the IMA function to retrieve keyrings from the policy.

Defining a new policy option should be separate from modifying
functions.

Mimi

