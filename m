Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2074449FD91
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiA1QD7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 11:03:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240248AbiA1QD7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 11:03:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SFonVV010379;
        Fri, 28 Jan 2022 16:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gtiUGNNErj1tF6ZBPCrxpuaTVneQFhIz7Mui8/YHGbE=;
 b=eH9qWv0jWgek1Py9j78Kt0d5hIJjv6yuStHMFv7Tw1/e9VMfJC5mv2Kkl3miTfv/bffR
 HlGW43TR7AFUp75ZaUj/BAQ+QxsR9X/qOG5YhmO0LlQLt0Ltr45bviEMDB+4+Nha5b9t
 ysWS/m338bouelpvhwgojT2HwCIFolPjLFVXft6oShMlYvhKm+5t6SCDBJDUKEs7jIz1
 n/9OLIk8Q0JTJFryfUK7fp2HTjnnYlG/95IzPdInZ7z/jNrpKvp9lCfWPmo6dYFyNvXc
 iry1u8mT6SI7Ldzn99Z7kB8v/YkHJS+u15c6u6Rngf6OUStcAWbBnu+weuaDvbNEZLQ7 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvgqj3skb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:03:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SFox9n011204;
        Fri, 28 Jan 2022 16:03:46 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvgqj3sje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:03:46 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SG2WaV017346;
        Fri, 28 Jan 2022 16:03:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3dr9j9rk2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:03:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SG3fEx44368140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 16:03:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76FA7A4068;
        Fri, 28 Jan 2022 16:03:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27DF3A4060;
        Fri, 28 Jan 2022 16:03:39 +0000 (GMT)
Received: from sig-9-65-83-59.ibm.com (unknown [9.65.83.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 16:03:39 +0000 (GMT)
Message-ID: <a72131dea70845bd7741d7e9f4d49671d538aa79.camel@linux.ibm.com>
Subject: Re: [PATCH v9 09/23] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 28 Jan 2022 11:03:38 -0500
In-Reply-To: <be31137d-57d9-24f7-01f6-f33080dd4bba@linux.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-10-stefanb@linux.vnet.ibm.com>
         <1af8f2155730c38dcd510016fe82bc90e4acee39.camel@linux.ibm.com>
         <be31137d-57d9-24f7-01f6-f33080dd4bba@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wvz4tC0BTiAZ0g5VC94FeFwVo4JnkoHA
X-Proofpoint-ORIG-GUID: b32T8YgdimPamh-EsXgoSLFynR4y7Myp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_04,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-01-28 at 10:44 -0500, Stefan Berger wrote:
> On 1/27/22 17:30, Mimi Zohar wrote:
> > On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
> >> ima_namespace. This way each IMA namespace can set those variables
> >> independently.
> > This patch description needs to be expanded a bit, indicating why
> > they're being moved together.  These flags are needed when loading a
> > policy. Please also update the "struct ima_namespace" comment.
> 
> I'll extend the above sentence like this:
> 
> ... those variables independently in its instance of securityfs.

That doesn't explain anything as to what these flags are or how they're
used.  Perhaps something like,  "Move the variables - ima_write_mutex,
ima_fs_flag, and valid_policy - related to updating the IMA policy into
the ima_namespace.  This way each IMA namespace can set these variables
independently."

Did you notice my comment inline below?

thanks,

Mimi

