Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC24314068
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 21:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhBHUZO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 15:25:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236716AbhBHUXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 15:23:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118K28vk096043;
        Mon, 8 Feb 2021 15:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cqqi4Dsx+0JwYgph7hkabIg4dfB0Eib0Ys3DHCjRCX4=;
 b=dJ1WmoCCLp36kaN/IYU7GMg+3xrEbZjGI9U4BrNioXq+1o0OeQi+a1TvMKizHT3rD41i
 meCV2wzTKdRN/xAUTxxpxG8B4lDlaVJHz09MQ74eHvrbqh958PZlbX8MCkmkfN5kytUC
 mWfVkrqJHJiFccWE5ia/vs7aen8D6O8SLXJ4TD281MPPMmb9Oizuh2GlKHqVzXnsX8Tf
 1u6vWPK68035M+Tcim5CTf4trL2ILYtgu4rKIcY4b2zJ+bZm9qzfh84ZMNm2DOS7315g
 OdwVgQU+T3xbYRl7xHW12r3DHD9sab+UZzG2mTD9Qa2Cc//w74xUV47ajrqTgyQGIG0t 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kbs30t50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:23:03 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118K3WSe103024;
        Mon, 8 Feb 2021 15:23:03 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kbs30t4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:23:02 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118K7blH019956;
        Mon, 8 Feb 2021 20:23:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8abnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 20:23:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118KMnln32702738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 20:22:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC1D64C04A;
        Mon,  8 Feb 2021 20:22:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76364C040;
        Mon,  8 Feb 2021 20:22:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 20:22:55 +0000 (GMT)
Message-ID: <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] support for duplicate measurement of integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 08 Feb 2021 15:22:54 -0500
In-Reply-To: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_11:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
> IMA does not measure duplicate buffer data since TPM extend is a very
> expensive operation.  However, in some cases for integrity critical
> data, the measurement of duplicate data is necessary to accurately
> determine the current state of the system.  Eg, SELinux state changing
> from 'audit', to 'enforcing', and back to 'audit' again.  In this
> example, currently, IMA will not measure the last state change to
> 'audit'.  This limits the ability of attestation services to accurately
> determine the current state of the integrity critical data on the
> system.
> 
> This series addresses this gap by providing the ability to measure
> duplicate entries for integrity critical data, driven by policy.

The same reason for re-measuring buffer data is equally applicable to
files.  In both cases, the file or the buffer isn't re-measured if it
already exists in the htable.   Please don't limit this patch set to
just buffer data.

thanks,

Mimi

