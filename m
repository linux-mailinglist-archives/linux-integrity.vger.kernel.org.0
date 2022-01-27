Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A949E5F2
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 16:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiA0PYi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 10:24:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231421AbiA0PYh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 10:24:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RF11bC022756;
        Thu, 27 Jan 2022 15:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hUFEVcbtFFdXYF2aSiR/wks0GiXAIcRZVVzHOqM3ihk=;
 b=g6XfByjBBW2seZiHpoVX7JPCwOXPk/trg5NkkCB3jAJQlggnRITLIDkrnyULuWjIAWur
 46Tq8YXFm3lwI838b8AqTKlTZcglfQTqznxM8Kix62hhcaShjRbv0GFXLb1QDQjPoiPT
 5K+efyi1S/hER70bA2CKb2SAF83ZMpFCJnJR/lBlhImLwQ07MDaIzOI6mJgplnFK8sHR
 lcjRLnKH8sAp5SdHzSOJKYzwmanzPjOXS5bsDW/p1svDAmFmG/WxRewy7cw9WzbZb+Zc
 F/FOJFOGBQOnNC0hWgjK3ZsjTvFYsMSE4trp1+90CJP3TfghqnciETkkVOBT0Ggg5OJj lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duun6udee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:24:23 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RF15VE024417;
        Thu, 27 Jan 2022 15:24:22 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duun6uddw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:24:22 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RFIZUm013596;
        Thu, 27 Jan 2022 15:24:20 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jcnred-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:24:20 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RFOJD231850816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 15:24:19 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F03B26E060;
        Thu, 27 Jan 2022 15:24:18 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43D446E05B;
        Thu, 27 Jan 2022 15:24:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 15:24:14 +0000 (GMT)
Message-ID: <eb917dd4-fc8e-2c15-815d-4f9eaa971d60@linux.ibm.com>
Date:   Thu, 27 Jan 2022 10:24:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 21/23] ima: Introduce securityfs file to activate an
 IMA namespace
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-22-stefanb@linux.vnet.ibm.com>
 <20220126143140.awwlv3h2jqotng2n@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126143140.awwlv3h2jqotng2n@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i148xUf73sf1N-75QirIAyEQAE2QJY0I
X-Proofpoint-ORIG-GUID: zWQIkGBP0kakaTpkVfHC-99O5PQVzXnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 09:31, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:43PM -0500, Stefan Berger wrote:
>
> Hm, I'd rather do something like (uncompiled, untested):
>
> +static ssize_t ima_write_active(struct file *filp,
> 				const char __user *buf,
> 				size_t count, loff_t *ppos)
> {
> 	struct ima_namespace *ns = &init_ima_ns;
> 	int err;
> 	unsigned int active;
> 	char *kbuf = NULL;
> 	ssize_t length;
>
> 	if (count >= 3)
> 		return -EINVAL;
>
> 	/* No partial writes. */
> 	if (*ppos != 0)
> 		return -EINVAL;
>
> 	if (ns_active(ns))
> 		return -EBUSY;
>
> 	kbuf = memdup_user_nul(buf, count);
> 	if (IS_ERR(kbuf))
> 		return PTR_ERR(kbuf);
>
> 	err = kstrtouint(kbuf, 10, &active);
> 	kfree(kbuf);
> 	if (err)
> 		return err;
>
> 	if (active != 1)
> 		return -EINVAL;
>
> 	atomic_set(&ns->active, 1);
> 	return count;
> }

Rearranged it to look lik this?

static ssize_t ima_write_active(struct file *filp,
                                 const char __user *buf,
                                 size_t count, loff_t *ppos)
{
         struct ima_namespace *ns = &init_ima_ns;
         unsigned int active;
         char *kbuf;
         int err;

         if (ns_is_active(ns))
                 return -EBUSY;

         /* accepting '1\n' and '1\0' and no partial writes */
         if (count >= 3 || *ppos != 0)
                 return -EINVAL;

         kbuf = memdup_user_nul(buf, count);
         if (IS_ERR(kbuf))
                 return PTR_ERR(kbuf);

         err = kstrtouint(kbuf, 10, &active);
         kfree(kbuf);
         if (err)
                 return err;

         if (active != 1)
                 return -EINVAL;

         atomic_set(&ns->active, 1);
         return count;
}


