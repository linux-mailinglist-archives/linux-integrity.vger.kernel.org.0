Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F62F662C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhANQpX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 11:45:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbhANQpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 11:45:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10EGgr0d055922;
        Thu, 14 Jan 2021 11:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eF2v+ZQkH+xDAE5NMv5INoHHD/SQP10arN2yyBt97WQ=;
 b=WsrapMxyd9iyUDozV+uO91GC9y5cyb+oEhCeaqtoswYVcnzXrSB3DSqFUSNQrTvkW+1Z
 uuDDPm1NaN0dy+MxFUsc4obEpImciBsl4vVoYrU7bFsLiqRZyblly/NNJwOAIY/EYswU
 t0GgtX6RthB4x6Csk1XNZmqwaGUU/suu7yDJqqbrfIMeLxmUb0D7osYMMT8eGsfsuWdN
 algozukhSB/IzM1pDj/XTgQfhPWHKkLMDGurVbplRv5KOCCadR+zCYNuIaamutiL7AL3
 c0l0Mx3I2qjhgWW4a6Xq/qOJCmu9SpLZRMkcAjB+p4HisjNZMGnoeYBNQZI4Hmg056LP zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362sqbr12b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 11:44:36 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10EGh70k056353;
        Thu, 14 Jan 2021 11:44:36 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362sqbr11m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 11:44:36 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10EGbVht003453;
        Thu, 14 Jan 2021 16:44:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 35y448be54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 16:44:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10EGiQUF33161524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 16:44:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE11E4C046;
        Thu, 14 Jan 2021 16:44:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C3244C04E;
        Thu, 14 Jan 2021 16:44:28 +0000 (GMT)
Received: from sig-9-65-209-51.ibm.com (unknown [9.65.209.51])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 16:44:28 +0000 (GMT)
Message-ID: <99be76345f375bb2f485f08a53dcb8ed806dc538.camel@linux.ibm.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 14 Jan 2021 11:44:27 -0500
In-Reply-To: <fc80b1a1-ff4d-3bf2-59bd-2cb56135bf0f@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
         <20210108040708.8389-9-tusharsu@linux.microsoft.com>
         <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
         <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
         <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
         <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
         <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com>
         <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
         <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
         <3746bc7673df25354411151442a7772b867be396.camel@linux.ibm.com>
         <fc80b1a1-ff4d-3bf2-59bd-2cb56135bf0f@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_05:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Sasha]

Hi Lakshmi,

On Thu, 2021-01-14 at 08:22 -0800, Lakshmi Ramasubramanian wrote:
> On 1/13/21 6:49 PM, Mimi Zohar wrote:

> >>> Lakshmi is trying to address the situation where an event changes a
> >>> value, but then is restored to the original value.  The original and
> >>> subsequent events are measured, but restoring to the original value
> >>> isn't re-measured.  This isn't any different than when a file is
> >>> modified and then reverted.
> >>>
> >>> Instead of changing the name like this, which doesn't work for files,
> >>> allowing duplicate measurements should be generic, based on policy.
> >>
> >> Perhaps it is just the end of the day and I'm a bit tired, but I just
> >> read all of the above and I have no idea what your current thoughts
> >> are regarding this patch.
> > 
> > Other than appending the timestamp, which is a hack, the patch is fine.
> > Support for re-measuring an event can be upstreamed independently.
> > 
> 
> Thanks for clarifying the details related to duplicate measurement 
> detection and re-measuring.
> 
> I will keep the timestamp for the time being, even though its a hack, as 
> it helps with re-measuring state changes in SELinux. We will add support 
> for "policy driven" re-measurement as a subsequent patch series.

Once including the timestamp is upstreamed, removing it will be
difficult, especially if different userspace applications are dependent
on it.  Unless everyone is on board that removing the timestamp
wouldn't be considered a regression, it cannot be upstreamed.

thanks,

Mimi

