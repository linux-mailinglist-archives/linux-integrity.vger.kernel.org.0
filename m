Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA533D3995
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhGWKz6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 06:55:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231703AbhGWKz5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 06:55:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NBXjuC033153;
        Fri, 23 Jul 2021 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=EJjeS9McCvhUbjQPyK4pJH9oe5ZeqUnvGsm+FWcPcFY=;
 b=ng2YdhAWBHuKvzb5lOg0Z5lgSUtHu6Z2whVR3U5CrUVekALKflwvEETvWjAwlSId/Vkd
 3gzLvGuzR0c/t1qZpxS2xZcNXONLJkH9vBJOmX08ljJ61itnqTAvCgOgQpqaGVSPklKd
 ExRwY0VdS9z3SToeMEPzjKRJ49WdTm5NqtxOqYu+djzCpvc3KZXYdfC6YaLhLSPbeZze
 3rRz3JquCw4+xNbG5JSfw9b3qnHRdeg9A019ebjQlzulyT52EhdO7BAJH0e0cB9pVSbY
 fjwCUmTmt+X2/T2b5Eh7wl9cq1qNr83iFTM7m4HEvyJvfMlbI0EwizHKdUqcK+83a07s jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yuubt2hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:36:31 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NBXl28033378;
        Fri, 23 Jul 2021 07:36:30 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yuubt2gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:36:30 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NBWfmx032273;
        Fri, 23 Jul 2021 11:36:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 39upu89tym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 11:36:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NBaPFn29360572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 11:36:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC15A42047;
        Fri, 23 Jul 2021 11:36:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B386142042;
        Fri, 23 Jul 2021 11:36:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.74.193])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 11:36:24 +0000 (GMT)
Message-ID: <7841c6025e3f51db3cd74a330d37ae333d041dc5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] IMA: add policy support for restricting the
 accepted hash algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Fri, 23 Jul 2021 07:36:23 -0400
In-Reply-To: <20210720092404.120172-3-simon.thoby@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
         <20210720092404.120172-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gLufMrZVcbYApRcWz3dGVVRYKMFwPBmK
X-Proofpoint-GUID: HZpAg9kcWn5GUtLAcQqd9qApHZvDdYH7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_05:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-20 at 09:25 +0000, THOBY Simon wrote:
> This patch defines a new IMA policy rule option "appraise_hash=",
> that restricts the hash algorithms accepted for the extended attribute
> security.ima when appraising.
> This patch is *not* self-contained, as it plugs in the support for
> parsing the parameter and showing it to the user, but it doesn't enforce
> the hashes yet, this will come in a subsequent patch.

Right, in order for the patch set to be bisect safe, the order of
patches 2 & 3 should be reversed.  First implement the support, then
add the policy rule support.  Otherwise the policy rules could be
processed, but not enforced.

thanks,

Mimi

> 
> Here is an example of a valid rule that enforces the use of sha256 or
> sha512 when appraising iptables binaries:
>   appraise func=BPRM_CHECK obj_type=iptables_exec_t appraise_type=imasig appraise_hash=sha256,sha512
> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, in which case it requires the hash (which was then signed
> by a trusted private key) to have been generated with one of the
> whitelisted algorithms.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>


