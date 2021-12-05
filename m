Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9F468B38
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Dec 2021 14:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhLENtb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Dec 2021 08:49:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50368 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234262AbhLENtb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Dec 2021 08:49:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B5CN13K007443;
        Sun, 5 Dec 2021 13:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uq+AJfUUdXCU9Ajg5O7XIV10npUdSRW06wBMMOmm5y4=;
 b=EcdsgUG3f+ycK/ALvsNwaq20OWFxbUtTFVbHBhidm4sBh3TwyfyzqLMalUqDTCCMMwyM
 x24nsqRKYv9TP3FahCtLQnxHNqxRHs4tsh7l8X7ZVQo9ktnCCgLJBea+duXj/j2ZDmY9
 vZ6DzAuegfx+8sPH+lVuX8ml00u6sX1WmW0o9/qXaXAi2MY9+QmArn7L/V1Dkxt/1d6t
 QzyuKPqllBi/q+DO+2ljkSTMMyanxpnUHsU4owZwg3Bj9OshG7d3uUZlcsrWZOvFT/Kb
 uLVGAHzdUG4gN0KhrmqgPgLSqa5TpwrBc4CVoZWY8HqJ9TTOFW+pFS+tljOZUDsyTsB8 PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3crwcg8r4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B5Djq4Y005812;
        Sun, 5 Dec 2021 13:45:52 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3crwcg8r4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B5Dhkh3024052;
        Sun, 5 Dec 2021 13:45:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3cqyy8w912-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:50 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B5DcCIZ30081472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Dec 2021 13:38:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F479A404D;
        Sun,  5 Dec 2021 13:45:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D974A4051;
        Sun,  5 Dec 2021 13:45:47 +0000 (GMT)
Received: from sig-9-65-73-15.ibm.com (unknown [9.65.73.15])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  5 Dec 2021 13:45:47 +0000 (GMT)
Message-ID: <6922478fa0df30aae2e97a930a374b2a4e6a1d39.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] certs: export load_certificate_list() to be used
 outside certs/
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>,
        kernel test robot <lkp@intel.com>
Date:   Sun, 05 Dec 2021 08:45:46 -0500
In-Reply-To: <20211124204714.82514-2-nayna@linux.ibm.com>
References: <20211124204714.82514-1-nayna@linux.ibm.com>
         <20211124204714.82514-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l4kKLuKKRTmsdzCgwokd-b4aBt_QcyOX
X-Proofpoint-ORIG-GUID: d-bEQyz7SFuXcWn5SZP6YV76eH4BpOcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_04,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-11-24 at 15:47 -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Now, export load_certificate_list() outside certs/ to be used
> by other functions.
> 
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Thanks, Nayna.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

