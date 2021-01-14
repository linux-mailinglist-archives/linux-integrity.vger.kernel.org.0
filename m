Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51D52F57DF
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbhANCKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:10:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730421AbhANCKT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:10:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10E21gSP085411;
        Wed, 13 Jan 2021 21:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yO8Cs6Z6wq2Tuu/b+rcgyQuxeXhGRdj+H+Csv0c2SiU=;
 b=DOe2T7YgApNsyweg0SLA74KB279y6wTfUN+f1Ao4z/0Bof+7o9K7b1XukZYGEiaDKTyK
 e620iP2oLs/EEhQfhrvcx3qCkTFzA6WpDDWHqGQusxqk1xuIIrkhqoufDyzFrs6iyuU7
 ta7l//4+c1HbddcR0fcqW9MDVuydKACByrHA6NmYu4Epi8XpNgU+bC3CeQAIuERlxd2y
 fVY3HGecS3bpm0Bee8/0t8538NtRvwfNIbC5ne9J5G6Y50+RDcIEdiSxAWX6gL9PTB6/
 EZIpZHOTMWEtY5KZuqxsEWaWydNwDEUSp2aZzdQlaxkTlXtLta93H7hmgfj7qiIYVo55 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362cqerc0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 21:09:32 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10E23Md7096659;
        Wed, 13 Jan 2021 21:09:32 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362cqerby2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 21:09:32 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10E279c9018267;
        Thu, 14 Jan 2021 02:09:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 361wgq8j0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 02:09:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10E29Ms018809252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 02:09:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C101AA4055;
        Thu, 14 Jan 2021 02:09:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D46A4040;
        Thu, 14 Jan 2021 02:09:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.196])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 02:09:24 +0000 (GMT)
Message-ID: <73a82dff7be151298f51c0db6f3c4996ccf44a19.camel@linux.ibm.com>
Subject: Re: [PATCH v10 5/8] IMA: limit critical data measurement based on a
 label
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Wed, 13 Jan 2021 21:09:23 -0500
In-Reply-To: <20210108040708.8389-6-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
         <20210108040708.8389-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_14:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 20:07 -0800, Tushar Sugandhi wrote:
> Integrity critical data may belong to a single subsystem or it may
> arise from cross subsystem interaction.  Currently there is no mechanism
> to group or limit the data based on certain label.  Limiting and
> grouping critical data based on a label would make it flexible and
> configurable to measure.
> 
> Define "label:=", a new IMA policy condition, for the IMA func
> CRITICAL_DATA to allow grouping and limiting measurement of integrity
> critical data.
> 
> Limit the measurement to the labels that are specified in the IMA
> policy - CRITICAL_DATA+"label:=".  If "label:=" is not provided with
> the func CRITICAL_DATA, measure all the input integrity critical data.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

This is looking a lot better.

thanks,

Mimi

