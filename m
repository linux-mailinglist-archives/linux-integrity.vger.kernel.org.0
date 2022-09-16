Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09D5BAE02
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiIPNV0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIPNVZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 09:21:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6558B50;
        Fri, 16 Sep 2022 06:21:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GCux5t022063;
        Fri, 16 Sep 2022 13:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Srgf2qKYxVi9JvK1f8yknBSY0qAUpFinRzk4DDhX3Kk=;
 b=NR+LRvggLk+hm1zBwza0NvT1o4w5wqGnCEr01CKuVkPTqkReHPPxwc0zK9XWChTLcvlZ
 GxmrVpDCErUZH9ghIyqj/9qVPB4hg0Gf1DNIN70N3a6k4NEzJpwj4Dg6RCOttiiV3XkT
 PQ6B74OsKQ5dbZ2thEl5yum7WSzQmBoPU3PglXwo/rULuTNSjTTXYveSf7pjQEBfsfI+
 /xTTU5jmn3QmhEl77gSUMhr/8Sl7SVC7Jpkh081bvVRmyWZYfGf6Er/14pe+3XII/78s
 Yttg87Z693/tf8eYBWC3V6MiuCkBdPh752cZXrHKDofhEBfyipvtlQwANcctx4FIwEBm dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmsckhekj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:20:58 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28GCvcUX025095;
        Fri, 16 Sep 2022 13:20:58 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmsckheju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:20:58 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GDKtT0017033;
        Fri, 16 Sep 2022 13:20:56 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3jm918x9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:20:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GDKtI94457110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:20:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92BF7B2065;
        Fri, 16 Sep 2022 13:20:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73192B206A;
        Fri, 16 Sep 2022 13:20:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 13:20:55 +0000 (GMT)
Message-ID: <7f6a66e8-3b55-c8bb-e745-9251810283ab@linux.ibm.com>
Date:   Fri, 16 Sep 2022 09:20:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v14 00/26] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
 <7234a3e5-8b3c-3ac4-2e06-c6cffa46c10e@schaufler-ca.com>
 <556b21f9-56ae-7ff6-c38a-9ca856438a66@linux.ibm.com>
In-Reply-To: <556b21f9-56ae-7ff6-c38a-9ca856438a66@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCRHHPiWVSAsGiphRpdZELpNL8gZVsM6
X-Proofpoint-ORIG-GUID: 8QHSi_Ibh99Wqk0nOXJbQ6wp7uCU0-T1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160092
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/16/22 06:54, Stefan Berger wrote:
> 
> 
> On 9/15/22 20:56, Casey Schaufler wrote:
>> On 9/15/2022 12:31 PM, Stefan Berger wrote:
>>> The goal of this series of patches is to start with the namespacing of
>>> IMA and support auditing within an IMA namespace (IMA-ns) as the first
>>> step.
>>>
>>> In this series the IMA namespace is piggybacking on the user namespace
>>> and therefore an IMA namespace is created when a user namespace is
>>> created, although this is done late when SecurityFS is mounted inside
>>> a user namespace. The advantage of piggybacking on the user namespace
>>> is that the user namespace can provide the keys infrastructure that IMA
>>> appraisal support will need later on.
>>>
>>> We chose the goal of supporting auditing within an IMA namespace 
>>> since it
>>> requires the least changes to IMA. Following this series, auditing 
>>> within
>>> an IMA namespace can be activated by a root running the following lines
>>> that rely on a statically linked busybox to be installed on the host for
>>> execution within the minimal container environment:
>>>
>>> As root (since audit rules may now only be set by root):
>>
>> How about calling out the required capabilities? You don't need
>> to be root, you need a specific set of capabilities. It would be
>> very useful for the purposes of understanding the security value
>> of the patch set to know this.
>>
> CAP_AUDIT_WRITE?
> 

Currently the capabilities that are required are CAP_SYS_ADMIN, which I 
could change to CAP_AUDIT_WRITE. This would result in the following 
change to 26/26:

  diff --git a/security/integrity/ima/ima_policy.c 
b/security/integrity/ima/ima_policy.c
index 760e79bb5a34..40cd19d38f23 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1396,15 +1396,15 @@ static unsigned int 
ima_parse_appraise_algos(char *arg)
  }

  /*
- * Either host root with CAP_SYS_ADMIN in current user namespace or
- * root with CAP_SYS_ADMIN on the host entering a namespace may set
+ * Either host root with CAP_AUDIT_WRITE in current user namespace or
+ * root with CAP_AUDIT_WRITE on the host entering a namespace may set
   * audit rules inside a namespace.
   */
  static bool may_set_audit_rule_in_ns(kuid_t uid, struct user_namespace 
*user_ns)
  {
         return (uid_eq(uid, GLOBAL_ROOT_UID) &&
-               ns_capable(user_ns, CAP_SYS_ADMIN))
-               || capable(CAP_SYS_ADMIN);
+               ns_capable(user_ns, CAP_AUDIT_WRITE))
+               || capable(CAP_AUDIT_WRITE);
  }
  static int ima_parse_rule(struct user_namespace *user_ns,
                           char *rule, struct ima_rule_entry *entry)


What this check is to prevent is that non-root users spawn a user 
namespace and set IMA-audit rules which enables them to flood the audit 
log. From what I see non-root users have the full capability set in a 
user namespace they spawn. So it has to be filtered to root maybe with 
CAP_SYS_WRITE instead of CAP_SYS_ADMIN.
