Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19A1F9EBE
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgFORor (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 13:44:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbgFORoq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 13:44:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FHfUGt010936;
        Mon, 15 Jun 2020 13:44:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31np7brx08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 13:44:39 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FHfrn1013137;
        Mon, 15 Jun 2020 13:44:39 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31np7brwyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 13:44:39 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FHeKHU030081;
        Mon, 15 Jun 2020 17:44:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 31mpe840c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 17:44:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FHiZMp59047984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 17:44:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F20B742045;
        Mon, 15 Jun 2020 17:44:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D126842042;
        Mon, 15 Jun 2020 17:44:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.11])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jun 2020 17:44:33 +0000 (GMT)
Message-ID: <1592243068.11061.155.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security
 state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     Stephen Smalley <stephen.smalley@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jun 2020 13:44:28 -0400
In-Reply-To: <2df1bc4f-675d-7868-de5b-1256346f982e@schaufler-ca.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
         <20200613024130.3356-5-nramas@linux.microsoft.com>
         <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
         <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
         <2df1bc4f-675d-7868-de5b-1256346f982e@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_07:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 clxscore=1015
 cotscore=-2147483648 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

(Cc'ing John)

On Mon, 2020-06-15 at 10:33 -0700, Casey Schaufler wrote:
> On 6/15/2020 9:45 AM, Lakshmi Ramasubramanian wrote:
> > On 6/15/20 4:57 AM, Stephen Smalley wrote:
> >
> > Hi Stephen,
> >
> > Thanks for reviewing the patches.
> >
> >>> +void security_state_change(char *lsm_name, void *state, int state_len)
> >>> +{
> >>> +       ima_lsm_state(lsm_name, state, state_len);
> >>> +}
> >>> +
> >>
> >> What's the benefit of this trivial function instead of just calling
> >> ima_lsm_state() directly?
> >
> > One of the feedback Casey Schaufler had given earlier was that calling an IMA function directly from SELinux (or, any of the Security Modules) would be a layering violation.
> 
> Hiding the ima_lsm_state() call doesn't address the layering.
> The point is that SELinux code being called from IMA (or the
> other way around) breaks the subsystem isolation. Unfortunately,
> it isn't obvious to me how you would go about what you're doing
> without integrating the subsystems.

Casey, I'm not sure why you think there is a layering issue here.
 There were multiple iterations of IMA before it was upstreamed.  One
iteration had separate integrity hooks(LIM).  Only when the IMA calls
and the security hooks are co-located, are they combined, as requested
by Linus.

There was some AppArmour discussion about calling IMA directly, but I
haven't heard about it in a while or seen the patch.

Mimi
