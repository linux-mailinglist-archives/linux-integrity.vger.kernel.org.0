Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167E523CCDB
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgHERJO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 13:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728453AbgHEREv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:04:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075H3NZ0092705;
        Wed, 5 Aug 2020 13:03:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qtnvccjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 13:03:41 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075H3dbq094591;
        Wed, 5 Aug 2020 13:03:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qtnvccf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 13:03:40 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075GsubG030897;
        Wed, 5 Aug 2020 17:03:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 32n018atg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 17:03:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075H3W4a22872388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 17:03:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 965AB42045;
        Wed,  5 Aug 2020 17:03:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A174242042;
        Wed,  5 Aug 2020 17:03:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 17:03:29 +0000 (GMT)
Message-ID: <69810007161e689ac817099fb1c6df21962963e4.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, sashal@kernel.org,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 13:03:28 -0400
In-Reply-To: <20200805154504.GB4365@sequoia>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
         <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
         <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
         <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
         <20200805154504.GB4365@sequoia>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_13:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=905
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-05 at 10:45 -0500, Tyler Hicks wrote:

> In addition to SELINUX_STATE and SELINUX_POLICY, we should also consider
> the proposed LSM_STATE and LSM_POLICY func values but require an "lsm"
> rule conditional.
> 
> So the current proposed rules:
> 
>  measure func=LSM_STATE
>  measure func=LSM_POLICY
> 
> Would become:
> 
>  measure func=LSM_STATE lsm=selinux
>  measure func=LSM_POLICY lsm=selinux
> 
> The following rules would be rejected:
> 
>  measure func=LSM_STATE
>  measure func=LSM_POLICY
>  measure func=LSM_STATE lsm=apparmor
>  measure func=LSM_POLICY lsm=smack

Kees is cleaning up the firmware code which differentiated between how
firmware was loaded.   There will be a single firmware enumeration.

Similarly, the new IMA hook to measure critical state may be placed in
multiple places.  Is there really a need from a policy perspective for
differentiating the source of the critical state being measurind?   The
data being measured should include some identifying information.

I think moving away from the idea that measuring "critical" data should
be limited to LSMs, will clarify this.

Mimi

