Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8184229660C
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Oct 2020 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371803AbgJVUjO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 16:39:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58962 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371802AbgJVUjN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 16:39:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MKW2Cm111815;
        Thu, 22 Oct 2020 16:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IFuZQiHZ5zXbarGP2kD9hqxg+2/2m9MRsUj82P5IF+o=;
 b=TjRSM/KCvMWOk4tPQl5BBK77cOPKCTwTm8VHXO55enbCUNuxNZAM6+hMueFsxH/LEQiO
 6NgzU+I5tHykIvsRK2k7C5YFBNxUBIJFhbiZeO7POyo1Zk3ChKOlZ8iBF+yobkDMm/cN
 zXFFkvM5M/79F/HoVRD79Yjs5P0bUlYr7MibUBHub2RQn0j+qeL8vDgTkxkGG+WpmnbW
 N0zpGGNXY89pnnSMajLQVMZjVfRjpja45RiIMXnlIT71aM523+JytmPeDyWLuDq9I79z
 VUeMT7BicNxKknQ9pHnPGnDi5Appq94f3pc5glNR1mc0Fxik11zpGVQe0nf+vj/bquB3 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34bh7085au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 16:39:07 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MKW5Cv111907;
        Thu, 22 Oct 2020 16:39:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34bh7085a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 16:39:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MK7Dla011995;
        Thu, 22 Oct 2020 20:39:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 348d5qw1d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 20:39:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MKd2oa18874790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 20:39:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87ECAA405F;
        Thu, 22 Oct 2020 20:39:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75903A4060;
        Thu, 22 Oct 2020 20:38:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.44])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 20:38:59 +0000 (GMT)
Message-ID: <7d9822da396a92645482e37a8c8590902323c5ef.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/6] IMA: conditionally allow empty rule data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 22 Oct 2020 16:38:58 -0400
In-Reply-To: <20200923192011.5293-3-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
         <20200923192011.5293-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_15:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
> ima_match_rule_data() permits the func to pass empty func_data.
> For instance, for the following func, the func_data keyrings= is
> optional.
>     measure func=KEY_CHECK keyrings=.ima
> 
> But a new func in future may want to constrain the func_data to
> be non-empty.  ima_match_rule_data() should support this constraint
> and it shouldn't be hard-coded in ima_match_rule_data().
> 
> Update ima_match_rule_data() to conditionally allow empty func_data
> for the func that needs it.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Policy rules may constrain what is measured, but that decision should
be left to the system owner or admin.

Mimi

