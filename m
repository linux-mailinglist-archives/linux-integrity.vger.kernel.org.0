Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE649EE1A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 23:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbiA0WbN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 17:31:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239018AbiA0WbN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 17:31:13 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RMGVDh021830;
        Thu, 27 Jan 2022 22:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6DQwW1n1rFFPj+I0A6JZLhXnhKQTUqIZZ4Q2/P4CPSg=;
 b=bVzSZMmfNjeQldwlS7OUD9avXRT7pBPvCJRiUSGDJUySHh9WqvC92lpdSTCXHjN2K2jG
 wUgUBDKMXZkkaOk/VrmNJouvyOSH3acdBALqwVaidcGHbsprlpABM+UBq/u4CyYD8q0n
 1s+gqTWoSzUKT4BRiNSs90MLB61hYBxrTOY73aDxJiUln98hE5EYPSBKTPKaupOMHv7I
 d6txy/1CQG05/0KnJ+g6eMKwO2zq/EzvWP0UarwET7AJiZv8qBI0psqslMQlngOEuu9K
 dTHlcZwh5PEI+rBgn42bOG5N6fpGhZd9ALkbhjieoJmqkf5wQ0IcjfNIsDGh0IM1dAyx vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dv41xr77j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 22:30:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RMOEYn021310;
        Thu, 27 Jan 2022 22:30:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dv41xr76d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 22:30:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RMC5R9011067;
        Thu, 27 Jan 2022 22:30:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9v4uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 22:30:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RMUjpq43581890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 22:30:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D24F4204D;
        Thu, 27 Jan 2022 22:30:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38B7242041;
        Thu, 27 Jan 2022 22:30:42 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 22:30:42 +0000 (GMT)
Message-ID: <1af8f2155730c38dcd510016fe82bc90e4acee39.camel@linux.ibm.com>
Subject: Re: [PATCH v9 09/23] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 27 Jan 2022 17:30:41 -0500
In-Reply-To: <20220125224645.79319-10-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-10-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fp9yCN7rNmNBBbrgX3DmlnSa09PCQ72-
X-Proofpoint-ORIG-GUID: SiL1PgoQ4gup1jydVK-GppccP03MmVjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_05,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
> ima_namespace. This way each IMA namespace can set those variables
> independently.

This patch description needs to be expanded a bit, indicating why
they're being moved together.  These flags are needed when loading a
policy. Please also update the "struct ima_namespace" comment.

thanks,

Mimi

