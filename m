Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFF2B1301
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 01:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKMAGU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 19:06:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgKMAGT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 19:06:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD03aCQ112547;
        Thu, 12 Nov 2020 19:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uTunqPCGUSXr0RxtZCQ56jIpu9N7YdTuKjaR/BVrIbc=;
 b=OWQlrZ0zJIiXHAYf1J7iG49F0WhcLKqtmMlBpa8+JbOrPXtiv27umB7IJwCiyrotARdd
 Ef2+7zs6PYR3MK6Wt54XwzAICS3XaMaEy5izg2ydaic2oh2HH5hjSz/sqRAAyzMLvoi2
 cbb1oAT0GthQblkyrn4wacv3NxVAyhEqs6AAVRBeguGEk/gp9J0asZjwMFYm1yk/wsOY
 Sa3y+8qvMTRnj7lyABIxNU12j1YF6YbLalmkWKFWwckEXevBfu4j+Ev7GN6MspXh6ZZt
 gVP4Hlfw3KaUaJjhgy/wYMa9bkusX3sivslJo93NAfcG+DJmxg1vWnPMlS4mDcPa114T 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sdrejfkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 19:06:14 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AD03rlp113627;
        Thu, 12 Nov 2020 19:06:13 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sdrejfje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 19:06:13 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACNvdgB024333;
        Fri, 13 Nov 2020 00:06:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 34njuh354q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 00:06:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AD068EB5898830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 00:06:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3545411C050;
        Fri, 13 Nov 2020 00:06:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B371911C069;
        Fri, 13 Nov 2020 00:06:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.105.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Nov 2020 00:06:04 +0000 (GMT)
Message-ID: <5d8f83824f44cc3dd3963c83f70121b18c1ab3ca.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] IMA: validate supported kernel data sources
 before measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 12 Nov 2020 19:06:03 -0500
In-Reply-To: <5826d3df-c263-f6c8-cac0-094b3c5a9395@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-6-tusharsu@linux.microsoft.com>
         <bef97a69db37d358db21668b179fd8821430b1b4.camel@linux.ibm.com>
         <5826d3df-c263-f6c8-cac0-094b3c5a9395@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=987 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Thu, 2020-11-12 at 14:09 -0800, Tushar Sugandhi wrote:
> Could you please let me know if you want us to remove this patch?

As neither of us are convinced this is necessary, please drop it.

Mimi

