Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B36445BD0
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Nov 2021 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhKDVt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 17:49:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231183AbhKDVt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 17:49:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4JHKj7030633;
        Thu, 4 Nov 2021 21:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5q9K+HCMAc5o18UGrrIj+QOYhLTgHlvvy+tcV621Ny8=;
 b=r65WJ9r03oVAjQlYl7cOj3TfVvP7RPHk7eAu+dwv2I8Ertsyb/NCnOm1PRnJHIxv/YOG
 sC24JAhD5NTsMdA3vYDfdYuKIYPK1cQzRJlvaiEz1/llVNjCuzyLDTEi2Jhg/XfGaJAR
 h55xVRGb/6442ejs9DveXIhpM0CrUJnh04h5eGkZd0sVrimq5QqBfo6F9E34PPuF8LhT
 JwO8ZKgpeK6kaiKOcbIVYaekZmVdJfbobH7YKZYEsQ5AN+nb+vy89EBRrAF6VkAtkH3h
 iWIxHNiGPKinQfZozkqkE0YZYV5ADyEifwjCp6J7p/hg0rl0cKdEg6l2ZK3F9bkQ1QYz cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c4mp2br6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 21:46:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A4LK9VO022302;
        Thu, 4 Nov 2021 21:46:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c4mp2br5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 21:46:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A4LhiYD017025;
        Thu, 4 Nov 2021 21:46:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3c0wpabx9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 21:46:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A4LeGks55968050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Nov 2021 21:40:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA70A4053;
        Thu,  4 Nov 2021 21:46:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F628A4051;
        Thu,  4 Nov 2021 21:46:41 +0000 (GMT)
Received: from sig-9-65-80-116.ibm.com (unknown [9.65.80.116])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Nov 2021 21:46:41 +0000 (GMT)
Message-ID: <938f819679a810c2a724afc5d6b5e1335815cb75.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] integrity: disassociate ima_filter_rule from
 security_audit_rule
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Thu, 04 Nov 2021 17:46:40 -0400
In-Reply-To: <b68c16b7-891c-5f60-7e85-4f4d6c331283@schaufler-ca.com>
References: <b68c16b7-891c-5f60-7e85-4f4d6c331283.ref@schaufler-ca.com>
         <b68c16b7-891c-5f60-7e85-4f4d6c331283@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KXh5sEVzs_BtG58e3yTMM6Gx9ZDynsCj
X-Proofpoint-ORIG-GUID: h8eo_jmlFywYFNdQCsLM0hFG2kvDVx0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_07,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

On Thu, 2021-11-04 at 14:38 -0700, Casey Schaufler wrote:
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new functions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

It looks fine to me.

Mimi

