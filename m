Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B82DD590
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgLQQ5q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 11:57:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgLQQ5q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 11:57:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHGjjPt055827;
        Thu, 17 Dec 2020 11:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gJos5ncnoCS2r+fHlV22ImN7sk1ihPQUjja817/z6tA=;
 b=WyU6cGg9rYBBoFToNxrDAydaRnYjOYnXpWFYNQ/Yojq8ahXnk1F+gZy9juqIPhtP4yW+
 TTbE23+fQaV+DcXVtk5yrpWJERhiE1C8VTmDDiyScWflH8nbDdQ8O35AmMqQN+LwanE2
 GbozWx2b5+HP+oK609Jd/92IAEt8I+oqgkX17u2CcpBF/VaHpMctNgEMge8LNF8xHJWO
 c9VfAoJFMti5+9fgyzvTEqfh3ZCn9X6/I9nGxlpadKdQeOTdODfmd4/7EL/ZhgoVXRo5
 NTLgth5jJRYQVG4mcoDDpVlbQtBEnW2ffZfAGF0I8HpXTx02r0uYZe4ey3x6uf6yg47Z xw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35gb4vr8rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 11:56:58 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHGqTqe005595;
        Thu, 17 Dec 2020 16:56:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 35d310ama2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 16:56:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHGurLk31850822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 16:56:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBA1611C078;
        Thu, 17 Dec 2020 16:56:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F43211C07F;
        Thu, 17 Dec 2020 16:56:52 +0000 (GMT)
Received: from sig-9-65-203-134.ibm.com (unknown [9.65.203.134])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Dec 2020 16:56:52 +0000 (GMT)
Message-ID: <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 17 Dec 2020 11:56:51 -0500
In-Reply-To: <20201214221946.6340-2-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
         <20201214221946.6340-2-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

Thank you!

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> To be reusable by more tests (preparation for next commit).
> 
> Call set_digest_index() inside get_algorithm_digest() if needed
> instead of expecting get_algorithm_digest() caller to call
> set_digest_index() before.

For the existing builtin templates, the algorithm/digest field is
consistent.  With support for per policy rule template formats, there
isn't necessarily a single template format for the entire list.

In the future "set_digest_index" might need to be renamed to
"get_digest_index" and the lookup done for each line.

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

