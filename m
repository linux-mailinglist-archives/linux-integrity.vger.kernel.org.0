Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80B49EDB7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 22:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiA0Vs0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 16:48:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbiA0VsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 16:48:25 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RKB8YD015985;
        Thu, 27 Jan 2022 21:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CPzbPy3WUpinKj9txwr3YVXa7tidg38Hckcwmwx2x9s=;
 b=ks68cXX0tRwB2JrlDh3WhvJixKA5HCInu7LewVTkFuOn/unK0SzhN0wypdc3FjJhLttN
 D7REtlyjSFyBBOWN5AS+38+FPUazlQcRMLDn+qoaO2RKxLl0cdSqiTUOtujGcvOVpMQH
 UkFB4Zo37bTfBLBktJqvIYprWI0nyKr3btptNhgx4vk4hj9hiYDmsJcjHokCCBrM55d7
 UVdI+/Rm2dzqM55V5mYEi0K8albhT2JSChrG8SKWnpd0ycAx1KeDfFecXWVmoZnVXBxp
 Kv6kydwLrdifKGvXyYz+udFe9KCsG1yHdQ0Ujur5tSdnoI5ddO1vxs0o22MPQ71BkRY0 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duy5awret-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 21:48:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RLmBva026318;
        Thu, 27 Jan 2022 21:48:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duy5awre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 21:48:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RLgdxR015714;
        Thu, 27 Jan 2022 21:48:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96k1shj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 21:48:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RLcQCZ49414534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 21:38:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AFFB11C050;
        Thu, 27 Jan 2022 21:48:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C912411C04C;
        Thu, 27 Jan 2022 21:48:01 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 21:48:01 +0000 (GMT)
Message-ID: <fc0fda8455140dce4f5af25fa8deef66ba931a95.camel@linux.ibm.com>
Subject: Re: [PATCH v9 08/23] ima: Move measurement list related variables
 into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 27 Jan 2022 16:48:01 -0500
In-Reply-To: <9ca21852-17ee-fc99-4764-300cd5199810@linux.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-9-stefanb@linux.vnet.ibm.com>
         <20220126092159.4rgclr5s3jli7aqy@wittgenstein>
         <9ca21852-17ee-fc99-4764-300cd5199810@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: St7UAdY_GMdBMO2QPeue07cQcI_lag1x
X-Proofpoint-GUID: a3v9IBRO8y4ZhCLpDXhJIOamLy-pKsBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_05,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-26 at 17:23 -0500, Stefan Berger wrote:
> On 1/26/22 04:21, Christian Brauner wrote:
> > On Tue, Jan 25, 2022 at 05:46:30PM -0500, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Move measurement list related variables into the ima_namespace. This way
> >> a front-end like securityfs can show the measurement list inside an IMA
> >> namespace.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> ---
> >>   security/integrity/ima/ima.h             |  5 +++--
> >>   security/integrity/ima/ima_fs.c          |  6 ++++--
> >>   security/integrity/ima/ima_init_ima_ns.c |  5 +++++
> >>   security/integrity/ima/ima_kexec.c       | 12 ++++++-----
> >>   security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
> >>   5 files changed, 31 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >> index 340a59174670..45706836a77b 100644
> >> --- a/security/integrity/ima/ima.h
> >> +++ b/security/integrity/ima/ima.h
> >> @@ -106,7 +106,6 @@ struct ima_queue_entry {
> >>   	struct list_head later;		/* place in ima_measurements list */
> >>   	struct ima_template_entry *entry;
> >>   };
> >> -extern struct list_head ima_measurements;	/* list of all measurements */
> >>   
> >>   /* Some details preceding the binary serialized measurement list */
> >>   struct ima_kexec_hdr {
> >> @@ -136,6 +135,8 @@ struct ima_namespace {
> >>   	struct ima_rule_entry *arch_policy_entry;
> >>   
> >>   	struct ima_h_table ima_htable;
> >> +	struct list_head ima_measurements;	/* list of all measurements */
> >> +	unsigned long binary_runtime_size;	/* used by init_ima_ns */
> >>   } __randomize_layout;
> > Moving this into struct imans seems sane to me but I'm not going to ack
> > it because I don't have enough knowledge to guarantee that this code
> > will only run for init_ima_ns. I'll leave that to Mimi.

Moving the ima_measurements to the ima_namespace is needed for
namespacing the IMA measurement list (next stage).  I think moving it
now is fine.

> 
> The code modifying binary_runtime_size may do this for all IMA 
> namespaces but the esulting value of binary_runtime_size may only 
> matter in init_ima_ns (not 100% sure, but Mimi seems to say so). Moving 
> it into ima_namespace rather than special-casing the code keeps the code 
> readable.

Right, there are other changes like moving the binary_runtime_size to
the namespace, which aren't needed, but are being done, I guess, for
aesthetics.  The binary_runtime_size is only used for allocating the
memory needed for carrying the measurement list across kexec.  Anything
related to carrying or restoring the measurement list across kexec is
limited to ima_init_ns.

> 
> There are also some case in the code that may do something like this:
> 
> if (ns == &init_ima_ns)
> 
>      foo = xyz;
> 
> Those will go away when foo is moved into the namespace and then it 
> becomes ns->foo = xyz, which is much saner for readability but 
> unavoidable for some variables at this stage.

Since binary_runtime_size is limited to the ima_init_ns, should it be
conditional?

thanks,

Mimi

