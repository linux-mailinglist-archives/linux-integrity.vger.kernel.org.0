Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1A718804
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEaRFS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEaRFO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 13:05:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FF1A1;
        Wed, 31 May 2023 10:04:51 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VGsq2O022625;
        Wed, 31 May 2023 17:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uQ0CCBEToBEwg27vcqlDciqSB0H4SGNRVJuFIQ80byg=;
 b=ldnQNzA/wENtywlkstZm1F24OwpDrCxta1GVEinf7DeBJqvsl9QuraKUkore8TyRqOPJ
 mKEITCjV4hlybHzyNyFvbdVrdIEZWSVSDiavp3/pxgn4BUp0pf6ILmKK036RN7Mp/QGp
 eXfGlqD2rxIrIxQTp3aMPMb4WnyoD8qMt5jyiRCVHwARi64O3ytFvnfYC3E+uVn3UhPP
 0v7PRaLgcGcU4BEPOS3bZOVsjJrhM1SZSbsIQsiIZLphsmab2WCLQ4iRYcfphCRHBXwl
 Pct+fFe9aCJGFU6pNA3QpjyiTPLnPx/P7YZRXjxK2rDzwrpQZATVoEtYAEqU9/+zDFho GQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx9cx9sus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:04:39 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VGQJDt016752;
        Wed, 31 May 2023 17:01:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qu9g67wu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:01:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34VH1Owh8979198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 17:01:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF4458060;
        Wed, 31 May 2023 17:01:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8A2458056;
        Wed, 31 May 2023 17:01:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 31 May 2023 17:01:23 +0000 (GMT)
Message-ID: <0438f5e3-ca42-343b-e79e-5f7976ec8a62@linux.ibm.com>
Date:   Wed, 31 May 2023 13:01:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20230530205001.1302975-1-jarkko@kernel.org>
 <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
 <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r5jeZyel84Py9GQN1rT6wrXcd2xxSoGb
X-Proofpoint-ORIG-GUID: r5jeZyel84Py9GQN1rT6wrXcd2xxSoGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_11,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=785 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/31/23 12:32, Jarkko Sakkinen wrote:
> On Wed, 2023-05-31 at 11:20 -0400, Stefan Berger wrote:
>>
>> On 5/30/23 16:50, Jarkko Sakkinen wrote:
>>> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
>>>
>>> vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
>>> copy_from_user() and copy_to_user().
>>
>> And what is the problem with that? Is it not working?
> It is API contract and also clearly documented in the kernel documentation.

First, vtpm_proxy_fops_set_locality() does not exist

This may  be the function that is simulating a client sending a SET_LOCALITY command:

static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
{
	struct tpm_buf buf;
	int rc;
	const struct tpm_header *header;
	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);

	if (chip->flags & TPM_CHIP_FLAG_TPM2)
		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS,
				  TPM2_CC_SET_LOCALITY);
	else
		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
				  TPM_ORD_SET_LOCALITY);
	if (rc)
		return rc;
	tpm_buf_append_u8(&buf, locality);

	proxy_dev->state |= STATE_DRIVER_COMMAND;

	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");

	proxy_dev->state &= ~STATE_DRIVER_COMMAND;

	if (rc < 0) {
		locality = rc;
		goto out;
	}

	header = (const struct tpm_header *)buf.data;
	rc = be32_to_cpu(header->return_code);
	if (rc)
		locality = -1;

out:
	tpm_buf_destroy(&buf);

	return locality;
}

There is nothing wrong with the buffer being passed into the tpm_transmit_cmd function, which then causes the 'server side' to pick up the command (= swtpm picks up the command):

/**
  * vtpm_proxy_fops_read - Read TPM commands on 'server side'
  *
  * @filp: file pointer
  * @buf: read buffer
  * @count: number of bytes to read
  * @off: offset
  *
  * Return:
  *	Number of bytes read or negative error code
  */
static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
				    size_t count, loff_t *off)
{
	struct proxy_dev *proxy_dev = filp->private_data;
	size_t len;
	int sig, rc;

	sig = wait_event_interruptible(proxy_dev->wq,
		proxy_dev->req_len != 0 ||
		!(proxy_dev->state & STATE_OPENED_FLAG));
	if (sig)
		return -EINTR;

	mutex_lock(&proxy_dev->buf_lock);

	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
		mutex_unlock(&proxy_dev->buf_lock);
		return -EPIPE;
	}

	len = proxy_dev->req_len;

	if (count < len || len > sizeof(proxy_dev->buffer)) {
		mutex_unlock(&proxy_dev->buf_lock);
		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
			 count, len);
		return -EIO;
	}

	rc = copy_to_user(buf, proxy_dev->buffer, len);
	memset(proxy_dev->buffer, 0, len);
	proxy_dev->req_len = 0;

	if (!rc)
		proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;

	mutex_unlock(&proxy_dev->buf_lock);

	if (rc)
		return -EFAULT;

	return len;
}

This is swtpm picking up this command with its user buffer.

   So, I am not sure at this point what is wrong.

    Stefan

> 
> This should be obvious even if you have've consulted that documentation because
> both functions have 'user' suffix, and also the pointer is __user tagged.
> 
> To make things worse it is architecture specific. I'm worried that it will
> break in one of the 23 microarchitectures. Have you actually ever checked it
> does not?
> 
> I'm not also an expert of how all the possible CPUs in the world empower
> Linux to further restrict the move between different memory spaces. I'm
> quite sure that this does conflict neither with SMAP or SMEP on x86
> (because I know x86 pretty well), but who knows what they add in the
> future to the microarchitecture.
> 
>>> Factor out the crippled code away with help of an internal API for
>>> managing struct proxy_dev instances.
>>
>> What is crippled code?
> 
> Code that behaves badly, i.e. does not meat the expectations. Illegit use of
> in-kernel functions easily fits to the definition of crippled code.
> 
> Bad API behavior put aside, it is very inefficient implementation because it
> unnecessarily recurses tpm_transmit(), which makes extending the driver to
> any direction so much involved process, but we don't really need this as a
> rationale.
> 
> This needs to be fixed in a way or another. That is dictated by the API
> cotract so for that I do not really even need feedback because it is
> force majeure. I'm cool with alternatives or suggestions to the current
> fact, so please focus on that instead of asking question that kernel
> documentation provides you already all the answers.
> 
> BR, Jarkko
