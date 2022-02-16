Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E444B8BAC
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Feb 2022 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiBPOmT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Feb 2022 09:42:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiBPOmS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Feb 2022 09:42:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE365A2518;
        Wed, 16 Feb 2022 06:42:02 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GEetZj008916;
        Wed, 16 Feb 2022 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZPFyNUwqe0e7446wUJUu9M1/GNkHn2W792idSCSGZUQ=;
 b=Xw30z5tqjw6ikX6DF0qgyxfAIgT9hDKnwNOH3cUa5XFLTUwaTaT3cm3vZfGAIosuqDFQ
 mQeKMluQHQdWHCNndQCS8YmG3MT6eJUVHOJ5IJVOdVgetPPcCuHXA7GdNVVPsPfOJjR5
 BCh16TsUQNTZySmoH+m6wWy4NuHKO1kKyRPJVS0urDkog6fbmRHTfr+4V7Mt09x5z3AI
 l8Z0Yd4FyA0//f4AXsidZ+Mx4DsVaAe5vDvArLgucSAv5LhBRETngA91idmXs5txGAyc
 3yVB5m55B4PK727cVxXjkMFhf+dE5+DJydmp3bMMSKNQa93nPpyggeDB4pmWjd/uCtBC mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e914sbdfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 14:41:30 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GEfU8g010073;
        Wed, 16 Feb 2022 14:41:30 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e914sbdf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 14:41:29 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GES87H014722;
        Wed, 16 Feb 2022 14:41:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3e64ha03v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 14:41:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GEfKfH39059870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 14:41:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE9A8A405B;
        Wed, 16 Feb 2022 14:41:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A55AA4051;
        Wed, 16 Feb 2022 14:41:18 +0000 (GMT)
Received: from sig-9-65-92-254.ibm.com (unknown [9.65.92.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 14:41:18 +0000 (GMT)
Message-ID: <429010298df589687e1d1a09bac21e302d642c7e.camel@linux.ibm.com>
Subject: Re: [PATCH v10 05/27] ima: Define ima_namespace struct and start
 moving variables into it
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Wed, 16 Feb 2022 09:41:17 -0500
In-Reply-To: <20220201203735.164593-6-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-6-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Y04efHf54EaZ2KiR04g70xp6LkUvVRJ
X-Proofpoint-ORIG-GUID: huv53N5hBJFREyrTajk_mUMiB4UAtsaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_07,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Define the ima_namespace structure and the ima_namespace variable
> init_ima_ns for the host's IMA namespace. Implement basic functions for
> namespacing support.

Implement the basic functions - ima_ns_init()  and ima_init_namespace()
- for namespacing support.

> 
> Move variables related to the IMA policy into the ima_namespace. This way
> the IMA policy of an IMA namespace can be set and displayed using a
> front-end like securityfs.

> Implement ima_ns_from_file() to get the IMA namespace via the user
> namespace of the securityfs superblock that a file belongs to.

Currently, ima_ns_from_file() doesn't exist in this patch.

> 
> To get the current ima_namespace use &init_ima_ns when a function
> that is related to a policy rule is called.

In preparation for IMA namespacing, update the existing functions to
pass the ima_namespace struct.  For now, ...

> 
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>

After addressing the one inline comment,
	Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> ---

>  
> @@ -119,6 +117,17 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
>  
> +struct ima_namespace {
> +	/* policy rules */
> +	struct list_head ima_default_rules;
> +	struct list_head ima_policy_rules;
> +	struct list_head ima_temp_rules;

These local policy variables weren't previously commented, but with the
move to a structure it would be good to add comments.  For example, the
architecture policy rules persist even after a custom policy is loaded.

ima_default_rules: /* Kconfig, builtin, & arch rules */
ima_policy_rules:  /* arch & custom rules */

> +
> +	struct list_head __rcu *ima_rules;	/* current policy */

/* Pointer to the current policy */.

> +	int ima_policy_flag;
> +} __randomize_layout;
> +extern struct ima_namespace init_ima_ns;
> +
>  extern const int read_idmap[];
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> 
>  {
> +	struct ima_namespace *ns = &init_ima_ns;
>  	char *data;
>  	ssize_t result;
>  

