Return-Path: <linux-integrity+bounces-8420-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH5RNBrOgWl1JwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8420-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 11:29:46 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF7D7A9B
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25AFD30B0F22
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AF318152;
	Tue,  3 Feb 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKt7WRDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U268SWG5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E99318B95
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114440; cv=none; b=DsjWVNPIy2rirrKPdR+051QDwAssWuwWwOuU1+m0g9nsl1BbKynTVsxJXuWZB61VEd92kFXb2BhOpkHjr9MH1gtyIJlTsH6a7DufBlyv9s10vupj6iPJ+i87zmFn3zVqVDwDVvE0jvWiwUHA4rFh1vcBIqNrYtaoP99OgqEjXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114440; c=relaxed/simple;
	bh=RN7saYJFHPz3hLuw+02uX5v0h2HBugdWFHu9MqZrqT8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s43qU6K5uzod/nv44AFIuVinkubQzVzfL9tGhjMQwC+3MYJ4HJMgFfFv3V1JOeXEzHh9eCUKagrBm4aYNbt/1V9bAGoSPplYFV9M9h5nQqbc/Ly8AlXCZJBF39SD11aeXZoyz1AZuOrVqlcxYcHoQ9dYT1tmnt/M9unReRThCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKt7WRDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U268SWG5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6139t3wS3388099
	for <linux-integrity@vger.kernel.org>; Tue, 3 Feb 2026 10:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DOiKkAryeR4cVh5NaMfAP3GNMqr+vgUopJTYbKrHBq0=; b=LKt7WRDPYyS0Vyeb
	qgBMvh9HJIg2FoBHQcPWWCOdBJX+M0UWNwH4C/ynC0h9B+O8wJzoBrfiejDNAoz/
	SPXMqlJYXXVmi+oJ51qEQBsjHwnKv/J0b8P8cX5/lrYj+XKNhkj+7UmF1dcaepoE
	qYwQaLEnR+47vgJS9VwCD03KAclC2bUKF6bzkwMJByjYoJhyvQD33+g6k7ZPc0e/
	uUzS8X3cj3Yl0dkQBT64KTZ8GWo/kbYnLhd3RMbnvs72zJxAPVC387sxU+GV88In
	BX6cf7atNunTeskK3UdWkfcT/51vGK9CiIcpfbWPajVnFB4cReMRSwxWgcAGBAEZ
	UePMaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2xvbu3w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 03 Feb 2026 10:27:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71500f274so554392085a.1
        for <linux-integrity@vger.kernel.org>; Tue, 03 Feb 2026 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770114434; x=1770719234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DOiKkAryeR4cVh5NaMfAP3GNMqr+vgUopJTYbKrHBq0=;
        b=U268SWG55rzj1Ct3EYFWPp8u92n3urg/We6V0IBWo2p70NP+K7wum/oPyMvFxBNdL6
         4k72ODzTLoAWTt1EvyrmU/BjNo71f+zxXRM1uITGRYdEiOEm6+bB0hteryA07C1WdSPD
         YkEUktu/0cSHWLFzE9HPzeauxA2VaUn8gdZxQ1Rnja7l9aIBtzA1463v5ZpzrvlPko50
         yT+0secl5Hvo4nkZ+6cxtV97IWI/eOP4u/hnVQbGCGwYfq+p17+7qCCHG9mzGn+TsKOc
         Tddr9Zso8jJYAmX0sTf+FskHqmZwJNiJqnbosPUN+LjlXK9dpiQU3PhZDUQ4ScG2xQS5
         TyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114434; x=1770719234;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOiKkAryeR4cVh5NaMfAP3GNMqr+vgUopJTYbKrHBq0=;
        b=oKPh7m2S9AqtsPyMiOSTaBKjmNQVYj7tzCM6/8Iz+Hy/3g/PXWkcvprwKX5IFzmjpq
         l3uUJU38Zf0eLzRyyQ/Txr8QENs/+rYwgsM5HVKOV3GidE8pfgZy2821JRillxReSv3r
         TrfLP9/eGdabPRQeufjqSPWSas45IPKwKo9zHKEogXMDKsRWKcPeSgYwx5eOOR+/UqB3
         NL+7yrNGFFW+mZGqSmtVudbfPLD8slhrIo39vnpe2Q7IephR9FNRa9V+qDN/bMVXbh+4
         Y++XjP0arzH1qEF6k1jgtemq+aEXXulNcaUpy3TlGJbbKKOzFGOgSuPc9ONXPzchPnh7
         1pMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQx0VczRPNp33LTdNTl5hUJoPQBHWiBJWfd7kgeN+w7WynrWBAwZ9A72j5LoMAoXFMzBoHxg0oF0Z3bCjSBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKvZ+QA/bfdh+f/ubEoKvWlcEm4/u0ZDQYv2vBsnl0DexOwLK
	sH/b+HbAxi7K5Ssw9YbIQJ5O+RZXtM7dk26MNOkPK5e13yWdrpfvaGQkEp6nh1vMAPGTokx74tG
	jityLkPrOe4maL16x+h1NUa7UJ8VzmuHDF0czJPFjMwUzKE4tpw92nbPKuxvSGT7OAknagvU=
X-Gm-Gg: AZuq6aJMvNRPDxihFO+H7JAA+wig/YPKcfBUKbq1w8Vd1ATX19ZGVO3RpDCGFiJXlnh
	VCYwVYbLMnI4o+C4KJx9xN1XaaJaWQEZMn/9fLeFe21UTB0nZLgMeyjpz1GlHaKgOVt+yY9IMM6
	TUIk6Jk9yMMW1RDQFuPexxjXqrK+Z3KtvTDTHv5w4NrTr9Z6Tf7g0rEZ+/XzXa0AqBk7PQjR8Dj
	W6fTHgDI8D9vQKReOycpOQThO1YB/Ficnaj4NNC+4enQnrIz0jEXHBeqLGtBIPCoYJBoNunYBO8
	5FabSXScjN+edT9yT4o9Sre41YalvXR2cXyzLWXeGt9XuW3bTTtVnR/F5UtEqxHb7WSfU4gMDm4
	no2t2F6TKpDxHAEtQEhGwOQJGPEQrtm2pyp8QfGaCxp5Yckhl0Bb2JW+yaZPNXYnFyacO2Vb7jL
	Z1NxPNGptTZBoUgV72CwpBR/5UXHgrkt9EqzUg98rB8jPR9AMFRICIPTiQ5hw6aRJnhA07KJAjF
	rbD
X-Received: by 2002:a05:620a:1a9b:b0:8c6:db05:8eb5 with SMTP id af79cd13be357-8c9eb32b091mr1810203685a.67.1770114433303;
        Tue, 03 Feb 2026 02:27:13 -0800 (PST)
X-Received: by 2002:a05:620a:1a9b:b0:8c6:db05:8eb5 with SMTP id af79cd13be357-8c9eb32b091mr1810200085a.67.1770114432472;
        Tue, 03 Feb 2026 02:27:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4256a92sm9030831a12.5.2026.02.03.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:27:11 -0800 (PST)
Message-ID: <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 11:27:10 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org
Cc: jani.nikula@linux.intel.com, anisse@astier.eu, oleksandr@natalenko.name,
        linux-integrity@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260202204425.2614054-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cq9T-EMfe5dbE-ek07gIInJw0H43RiQ-
X-Proofpoint-ORIG-GUID: cq9T-EMfe5dbE-ek07gIInJw0H43RiQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MyBTYWx0ZWRfX0EK3CccmkQyj
 TX8tSywILRIliF3KDXgarYFy7k8HrnQaY/f8M7FHFP1+rRszavm1jJ8fZ9yGrSEc1ZG8T/YoqWU
 T/SB5+jLbrIWIJlmAxwT8T3+Ge481BC3izPwDpdhPHXR9CLdhISZI8GzYmxNrmQQwy5nyxZ/xeF
 Wz+CEHZ5vFQScjnk3acKor8Fb/KpprJI/bSZR3MwpMuBXZErJCmuFTi5YSFuPF6cMJF/geUw8Z0
 sXIozAUeLCxJQ3Ii4Z6mK7+nDgN9lq0avESMqmP8E/m2UKNBZk8XBTFmsDUaeJr+uJj8Xs/ki8g
 fHI8/H9QI7fT5F0j7GBybWol1FHw9RLSBEjtH2tegrP4L3IQXkuD4XrjzlHi7kApVSTd3WQC1H5
 bAbov4bhD6dhprYXbKWAe4dPhdqkgPyec5gSQiKW3DjXR1yJrXjzdVHL+shntVLq6u2nuMdX8Lk
 C2Ez4PrBS2jAcFH3V0Q==
X-Authority-Analysis: v=2.4 cv=AurjHe9P c=1 sm=1 tr=0 ts=6981cd82 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=0-pGC9Iswqwzjx7--dgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8420-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.goede@oss.qualcomm.com,linux-integrity@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CAF7D7A9B
X-Rspamd-Action: no action

Hi Jarkko,

On 2-Feb-26 21:44, Jarkko Sakkinen wrote:
> Already a quick Google survey backs strongly that OOT drivers (e.g.,
> v4l2loopback) are the defacto solution for streaming phone cameras in
> video conference calls, which puts confidential discussions at risk.
> 
> It can be also claimed that there's enough OOT usage in the wild that
> possible security bugs could be considered as potential zerodays for the
> benefit of malicious actors.
> 
> The situation has been stagnated for however many years, which is
> unsastainable situation, and it further factors potential security
> risks. Therefore, a driver is needed to address the popular use case.
> 
> vcam is a DMA-BUF backed virtual camera driver capable of creating video
> capture devices to which data can be streamed through /dev/vcam after
> calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> between capture and output.
> 
> This enables efficient implementation of software, which can manage network
> video streams from phone cameras, and map those streams to video devices.
> 
> PipeWire or any other specific pick of userspace software cannot really
> address the issue at scale, as e.g., the use of v4l2loopback is both wide
> and scattered.

I appreciate your efforts here and if I understand things correctly
your main goal is to allow people to use the camera of there mobile
phone for e.g. video-conferencing on a standard linux distro
(Debian/Fedora/Arch) laptop/desktop right ?

The problem is that what you're suggesting is basically a much
improved (using dma-buf is way better) v4l2-loopback driver and
v4l2-loopback has been blocked from getting merged into the kernel
because besides the mobile-phone camera use, the other main use-case
is to allow running proprietary camera stacks like Intel's proprietary
camerastack and then presenting that to userspace as a standard v4l2
cam so that userspace apps will just work.

Personally I think that there are enough valid use-cases for something
like your proposed vcam driver, also for e.g. CI purposes that I think
that maybe the V4L2 maintainers should reconsider. But this is not my
call to make and with both Laurent (in the v1 thread) and Sakari pretty
much having NACK-ed this, I do not think this is going to go very far
if you want a mainline solution.

As Sakari mentioned in this day and age raw V4L2 access is really not
the best API to acccess cameras. Especially modern smartphone like
CSI2 MIPI cameras which consist of quite a complex graph of building
blocks which need to be configured to work together to get a picture.

So now even when running directly on the hardware (vs the network case)
apps can no longer directly access v4l2 devices because of the complexity.

This is already the case on newer x86_64 laptops with MIPI cameras
instead of USB UVC cams and also on phones running postmarketos.

The community concensus is that the solution here is for apps to
access cameras through pipewire. Together with the shift of laptops
cameras from UVC to "raw" MIPI cameras there also is a shift to
running applications sandboxed as flatpacks because of the changing
"cyber" security landscape. This is why pipewire was chosen because
it also solves the accessing cameras from a sandbox issue.

Both Firefox and chrome(ium) already support pipewire for cameras
OOTB. In chrome it requires setting a config setting and maybe for
upstream Firefox too (it is enabled in Fedora's Firefox by default).

Given that pipewire is seen as the way to access all cameras in
the future and that we are already moving in that direction (e.g.
Fedora has been shipping this OOTB since Fedora 42) IMHO your time
would be better spend helping out there.

E.g. add support to popular software for sharing smartphone cameras
to represent the frames received over the network as a video sources
in pipewire and check if this works in Firefox + Chrome and write
patches or file issues for other apps to also add pipewire camera
access support.

As was mentioned in the earlier thread for making the camera show
up as a source in pipewire you could try using the pipewire sink
element in gstreamer, assuming you can make the phone-cam available
as a gstreamer src element, you may be able to prototype things
then using just a gst-launch cmd from the shell.

Regards,

Hans




> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Added motivation based on feedback to v1.
> - Provide a list of allowed modes for /dev/videoX in VCAM_IOC_CREATE.
> - Merged VCAM_IOC_WAIT and VCAM_IOC_STATUS.
> - Return state with operation flags in VCAM_IOC_WAIT.
> - Test program: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/vcam-test.git
> ---
>  .../driver-api/media/drivers/index.rst        |    1 +
>  .../driver-api/media/drivers/vcam.rst         |   16 +
>  MAINTAINERS                                   |    8 +
>  drivers/media/Kconfig                         |   13 +
>  drivers/media/Makefile                        |    1 +
>  drivers/media/vcam.c                          | 1935 +++++++++++++++++
>  include/uapi/linux/vcam.h                     |  141 ++
>  7 files changed, 2115 insertions(+)
>  create mode 100644 Documentation/driver-api/media/drivers/vcam.rst
>  create mode 100644 drivers/media/vcam.c
>  create mode 100644 include/uapi/linux/vcam.h
> 
> diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
> index 7f6f3dcd5c90..211cafc9c070 100644
> --- a/Documentation/driver-api/media/drivers/index.rst
> +++ b/Documentation/driver-api/media/drivers/index.rst
> @@ -27,6 +27,7 @@ Video4Linux (V4L) drivers
>  	zoran
>  	ccs/ccs
>  	ipu6
> +	vcam
>  
>  
>  Digital TV drivers
> diff --git a/Documentation/driver-api/media/drivers/vcam.rst b/Documentation/driver-api/media/drivers/vcam.rst
> new file mode 100644
> index 000000000000..b5a23144ebee
> --- /dev/null
> +++ b/Documentation/driver-api/media/drivers/vcam.rst
> @@ -0,0 +1,16 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +vcam: Virtual Camera Driver
> +===========================
> +
> +Theory of Operation
> +-------------------
> +
> +.. kernel-doc:: drivers/media/vcam.c
> +   :doc: Theory of Operation
> +
> +Driver uAPI
> +-----------
> +
> +.. kernel-doc:: include/uapi/linux/vcam.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6863d5fa07a1..b8444ff48716 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27504,6 +27504,14 @@ S:	Maintained
>  F:	drivers/media/common/videobuf2/*
>  F:	include/media/videobuf2-*
>  
> +VCAM V4L2 DRIVER
> +M:	Jarkko Sakkinen <jarkko@kernel.org>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> +F:	drivers/media/vcam.c
> +F:	include/uapi/linux/vcam.h
> +
>  VIDTV VIRTUAL DIGITAL TV DRIVER
>  M:	Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> index 6abc9302cd84..f2f4b2ec9135 100644
> --- a/drivers/media/Kconfig
> +++ b/drivers/media/Kconfig
> @@ -239,6 +239,19 @@ source "drivers/media/firewire/Kconfig"
>  # Common driver options
>  source "drivers/media/common/Kconfig"
>  
> +config VCAM
> +	tristate "V4L2 virtual camera"
> +	depends on VIDEO_DEV
> +	default m
> +	select VIDEOBUF2_VMALLOC
> +	help
> +	  Say Y here to enable a DMA-BUF backed virtual camera driver capable
> +	  of creating video capture devices to which data can be streamed
> +	  through /dev/vcam after calling VCAM_IOC_CREATE. Frames are pushed
> +	  with VCAM_IOC_QUEUE and recycled with VCAM_IOC_DEQUEUE.
> +
> +	  When in doubt, say N.
> +
>  endmenu
>  
>  #
> diff --git a/drivers/media/Makefile b/drivers/media/Makefile
> index 20fac24e4f0f..d539fecbe498 100644
> --- a/drivers/media/Makefile
> +++ b/drivers/media/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_CEC_CORE) += cec/
>  obj-y += common/ platform/ pci/ usb/ mmc/ firewire/ spi/ test-drivers/
>  obj-$(CONFIG_VIDEO_DEV) += radio/
>  
> +obj-$(CONFIG_VCAM) += vcam.o
> diff --git a/drivers/media/vcam.c b/drivers/media/vcam.c
> new file mode 100644
> index 000000000000..787e2585e12c
> --- /dev/null
> +++ b/drivers/media/vcam.c
> @@ -0,0 +1,1935 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Jarkko Sakkinen 2025-2026
> + *
> + * Derived originally from v4l2loopback driver but is essentially a rewrite.
> + */
> +
> +/**
> + * DOC: Theory of Operation
> + *
> + * The driver exposes /dev/vcam for creating virtual capture devices via
> + * %VCAM_IOC_CREATE. The ioctl registers a video capture node, stores the
> + * allowed capture modes provided by the caller, and associates output buffers
> + * described by &struct vcam_frame with DMA-BUF file descriptors supplied by
> + * the caller. This also keeps output buffers owned by the caller, and
> + * accounted from the calling process.
> + *
> + * Frames are pushed to the capture device by queueing output buffers using
> + * %VCAM_IOC_QUEUE, and recycling them with %VCAM_IOC_DEQUEUE. Queueing without
> + * dequeuing eventually exhausts the output queue and stalls the producer.
> + *
> + * If both buffers reference the same DMA-BUF, the driver performs a zero-copy
> + * transfer by propagating metadata. Otherwise, if both buffers are mappable,
> + * the payload is copied into the capture buffer. When neither zero-copy nor a
> + * CPU mapping is possible, the capture buffer completes with an error.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/bitops.h>
> +#include <linux/atomic.h>
> +#include <linux/ctype.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/limits.h>
> +#include <linux/device.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/poll.h>
> +#include <linux/sched.h>
> +#include <linux/time.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sort.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/videodev2.h>
> +#include <linux/wait.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/videobuf2-vmalloc.h>
> +#include <uapi/linux/vcam.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "vcam: " fmt
> +
> +MODULE_DESCRIPTION("V4L2 virtual camera driver");
> +MODULE_LICENSE("GPL");
> +
> +#define VCAM_CARD_LABEL_MAX sizeof_field(struct video_device, name)
> +#define VCAM_FPS_MIN 1
> +#define VCAM_FPS_MAX 1000
> +
> +#define VCAM_MIN_WIDTH 2
> +#define VCAM_MIN_HEIGHT 2
> +#define VCAM_MAX_WIDTH 8192
> +#define VCAM_MAX_HEIGHT 8192
> +#define VCAM_DEFAULT_WIDTH 640
> +#define VCAM_DEFAULT_HEIGHT 480
> +
> +#define VCAM_MAX_FORMATS 16
> +#define VCAM_MAX_MODES 64
> +#define VCAM_MIN_FRAMES 2
> +#define VCAM_MAX_FRAMES 32
> +
> +#define VCAM_STATUS_MASK (VCAM_STATUS_IDLE | VCAM_STATUS_STREAMING)
> +
> +enum vcam_flags {
> +	VCAM_FLAG_IS_OPEN = 0x01,
> +	VCAM_FLAG_CREATING = 0x02,
> +	VCAM_FLAG_READY = 0x04,
> +};
> +
> +struct vcam_buf {
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head list;
> +	unsigned long flags;
> +};
> +
> +enum vcam_buf_flags {
> +	VCAM_BUF_FLAG_MAPPABLE = BIT(0),
> +};
> +
> +struct vcam {
> +	unsigned long flags;
> +	int device_nr;
> +	struct v4l2_device v4l2_dev;
> +	struct video_device *vdev;
> +	struct vb2_queue capture_queue;
> +	struct vb2_queue output_queue;
> +	struct v4l2_pix_format pix_format;
> +	struct vcam_mode *modes;
> +	u32 nr_modes;
> +	struct v4l2_captureparm capture;
> +	atomic_t sequence;
> +	struct list_head capture_list;
> +	struct list_head output_list;
> +	u64 status;
> +	wait_queue_head_t status_waitq;
> +	enum vb2_memory output_memory;
> +
> +	/* Protects status flags and wait queue updates. */
> +	spinlock_t status_lock;
> +
> +	/* Shared lock for vdev and VB2 queues. */
> +	struct mutex lock;
> +
> +	/* Protects capture_list and output_list. */
> +	spinlock_t frame_lock;
> +
> +	/*
> +	 * Maintains a shared reference between processes having either
> +	 * /dev/vcam or /dev/videoX open.
> +	 */
> +	struct kref ref;
> +};
> +
> +enum vcam_format_flags {
> +	VCAM_PLANAR = BIT(0),
> +	VCAM_COMPRESSED = BIT(1),
> +};
> +
> +struct vcam_format {
> +	int fourcc;
> +	int depth;
> +	int flags;
> +};
> +
> +const struct vcam_format vcam_formats[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_YUYV,
> +		.depth = 16,
> +		.flags = 0,
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12,
> +		.depth = 12,
> +		.flags = VCAM_PLANAR,
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_MJPEG,
> +		.depth = 32,
> +		.flags = VCAM_COMPRESSED,
> +	},
> +};
> +
> +#define VCAM_NR_FORMATS ARRAY_SIZE(vcam_formats)
> +
> +static const struct vcam_format *vcam_find_format(int fourcc)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < VCAM_NR_FORMATS; i++) {
> +		if (vcam_formats[i].fourcc == fourcc)
> +			return vcam_formats + i;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void vcam_fmt_descr(char *dst, size_t dst_len, u32 format)
> +{
> +	snprintf(dst, dst_len, "[%c%c%c%c]", (format >> 0) & 0xFF,
> +		 (format >> 8) & 0xFF, (format >> 16) & 0xFF,
> +		 (format >> 24) & 0xFF);
> +}
> +
> +static void vcam_fourcc_str(char *dst, u32 format)
> +{
> +	dst[0] = (format >> 0) & 0xFF;
> +	dst[1] = (format >> 8) & 0xFF;
> +	dst[2] = (format >> 16) & 0xFF;
> +	dst[3] = (format >> 24) & 0xFF;
> +	dst[4] = '\0';
> +}
> +
> +static inline bool vcam_is_streaming(struct vcam *data)
> +{
> +	return vb2_is_streaming(&data->output_queue) ||
> +	       vb2_is_streaming(&data->capture_queue);
> +}
> +
> +static bool vcam_status_mask_ready(struct vcam *dev, u64 mask)
> +{
> +	unsigned long flags;
> +	bool ready;
> +
> +	spin_lock_irqsave(&dev->status_lock, flags);
> +	ready = (dev->status & mask) == mask;
> +	spin_unlock_irqrestore(&dev->status_lock, flags);
> +
> +	return ready;
> +}
> +
> +static void vcam_status_update_stream(struct vcam *dev, bool on)
> +{
> +	unsigned long flags;
> +	u64 old_flags;
> +	u64 new_flags;
> +
> +	spin_lock_irqsave(&dev->status_lock, flags);
> +	old_flags = dev->status;
> +	if (on) {
> +		dev->status &= ~VCAM_STATUS_IDLE;
> +		dev->status |= VCAM_STATUS_STREAMING;
> +	} else {
> +		dev->status &= ~VCAM_STATUS_STREAMING;
> +		dev->status |= VCAM_STATUS_IDLE;
> +	}
> +	new_flags = dev->status;
> +	spin_unlock_irqrestore(&dev->status_lock, flags);
> +
> +	if (new_flags != old_flags)
> +		wake_up_interruptible(&dev->status_waitq);
> +}
> +
> +static u64 vcam_status_read(struct vcam *dev)
> +{
> +	unsigned long flags;
> +	u64 flags_snapshot;
> +
> +	spin_lock_irqsave(&dev->status_lock, flags);
> +	flags_snapshot = dev->status;
> +	spin_unlock_irqrestore(&dev->status_lock, flags);
> +
> +	return flags_snapshot;
> +}
> +
> +static bool vcam_tpf_valid(const struct v4l2_fract *tpf)
> +{
> +	u64 min_den = (u64)tpf->numerator * VCAM_FPS_MIN;
> +	u64 max_den = (u64)tpf->numerator * VCAM_FPS_MAX;
> +
> +	if (!tpf->numerator || !tpf->denominator)
> +		return false;
> +	if ((u64)tpf->denominator < min_den)
> +		return false;
> +	if ((u64)tpf->denominator > max_den)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool vcam_pix_format_eq(const struct v4l2_pix_format *src,
> +			       const struct v4l2_pix_format *dest)
> +{
> +	return src->width == dest->width && src->height == dest->height &&
> +	       src->pixelformat == dest->pixelformat;
> +}
> +
> +static bool vcam_mode_has_pixelformat(const struct vcam *dev, u32 pixelformat)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < dev->nr_modes; i++) {
> +		if (dev->modes[i].pixelformat == pixelformat)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool vcam_mode_pixelformat_seen(const struct vcam *dev, u32 index,
> +				       u32 pixelformat)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < index; i++) {
> +		if (dev->modes[i].pixelformat == pixelformat)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool vcam_mode_framesize_seen(const struct vcam *dev, u32 index,
> +				     u32 pixelformat, u32 width, u32 height)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < index; i++) {
> +		const struct vcam_mode *mode = &dev->modes[i];
> +
> +		if (mode->pixelformat == pixelformat && mode->width == width &&
> +		    mode->height == height)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int vcam_mode_enum_format(const struct vcam *dev, u32 index,
> +				 u32 *pixelformat)
> +{
> +	u32 i;
> +	u32 match = 0;
> +
> +	for (i = 0; i < dev->nr_modes; i++) {
> +		u32 fmt = dev->modes[i].pixelformat;
> +
> +		if (vcam_mode_pixelformat_seen(dev, i, fmt))
> +			continue;
> +
> +		if (match++ == index) {
> +			*pixelformat = fmt;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vcam_mode_enum_framesize(const struct vcam *dev, u32 pixelformat,
> +				    u32 index, u32 *width, u32 *height)
> +{
> +	u32 i;
> +	u32 match = 0;
> +
> +	for (i = 0; i < dev->nr_modes; i++) {
> +		const struct vcam_mode *mode = &dev->modes[i];
> +
> +		if (mode->pixelformat != pixelformat)
> +			continue;
> +		if (vcam_mode_framesize_seen(dev, i, pixelformat, mode->width,
> +					     mode->height))
> +			continue;
> +		if (match++ == index) {
> +			*width = mode->width;
> +			*height = mode->height;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static bool vcam_mode_has_framesize(const struct vcam *dev, u32 pixelformat,
> +				    u32 width, u32 height)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < dev->nr_modes; i++) {
> +		const struct vcam_mode *mode = &dev->modes[i];
> +
> +		if (mode->pixelformat == pixelformat && mode->width == width &&
> +		    mode->height == height)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool vcam_mode_matches_pix(const struct vcam_mode *mode,
> +				  const struct v4l2_pix_format *pix)
> +{
> +	return mode->width == pix->width && mode->height == pix->height &&
> +	       mode->pixelformat == pix->pixelformat &&
> +	       mode->colorspace == pix->colorspace &&
> +	       mode->stride == pix->bytesperline;
> +}
> +
> +static int vcam_mode_cmp(const void *lhs, const void *rhs)
> +{
> +	const struct vcam_mode *a = lhs;
> +	const struct vcam_mode *b = rhs;
> +
> +	if (a->pixelformat != b->pixelformat)
> +		return (a->pixelformat > b->pixelformat) -
> +		       (a->pixelformat < b->pixelformat);
> +	if (a->width != b->width)
> +		return (a->width > b->width) - (a->width < b->width);
> +	if (a->height != b->height)
> +		return (a->height > b->height) - (a->height < b->height);
> +	if (a->colorspace != b->colorspace)
> +		return (a->colorspace > b->colorspace) -
> +		       (a->colorspace < b->colorspace);
> +	return (a->stride > b->stride) - (a->stride < b->stride);
> +}
> +
> +static bool vcam_mode_equal(const struct vcam_mode *a,
> +			    const struct vcam_mode *b)
> +{
> +	return a->width == b->width && a->height == b->height &&
> +	       a->pixelformat == b->pixelformat &&
> +	       a->colorspace == b->colorspace && a->stride == b->stride;
> +}
> +
> +static bool vcam_mode_allowed(const struct vcam *dev,
> +			      const struct v4l2_pix_format *pix)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < dev->nr_modes; i++) {
> +		if (vcam_mode_matches_pix(&dev->modes[i], pix))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int vcam_set_format(struct v4l2_format *fmt)
> +{
> +	struct v4l2_pix_format *pix = &fmt->fmt.pix;
> +	const struct vcam_format *format;
> +	u64 bytesperline;
> +	u64 sizeimage;
> +
> +	if (V4L2_TYPE_IS_MULTIPLANAR(fmt->type))
> +		return -EINVAL;
> +
> +	if (!pix->width)
> +		pix->width = VCAM_DEFAULT_WIDTH;
> +	if (!pix->height)
> +		pix->height = VCAM_DEFAULT_HEIGHT;
> +
> +	pix->width = clamp(pix->width, VCAM_MIN_WIDTH, VCAM_MAX_WIDTH);
> +	pix->height = clamp(pix->height, VCAM_MIN_HEIGHT, VCAM_MAX_HEIGHT);
> +
> +	format = vcam_find_format(pix->pixelformat);
> +	if (!format) {
> +		format = &vcam_formats[0];
> +		pix->pixelformat = format->fourcc;
> +	}
> +
> +	if (format->flags & VCAM_PLANAR) {
> +		pix->bytesperline = pix->width;
> +		sizeimage = ((u64)pix->width * pix->height * format->depth) >>
> +			    3;
> +	} else if (format->flags & VCAM_COMPRESSED) {
> +		pix->bytesperline = 0;
> +		sizeimage = ((u64)pix->width * pix->height * format->depth) >>
> +			    3;
> +	} else {
> +		bytesperline = ((u64)pix->width * format->depth) >> 3;
> +		if (bytesperline > U32_MAX)
> +			return -EOVERFLOW;
> +
> +		pix->bytesperline = bytesperline;
> +		sizeimage = (u64)pix->height * bytesperline;
> +	}
> +
> +	if (sizeimage > U32_MAX)
> +		return -EOVERFLOW;
> +
> +	pix->sizeimage = sizeimage;
> +
> +	if (pix->colorspace == V4L2_COLORSPACE_DEFAULT ||
> +	    pix->colorspace > V4L2_COLORSPACE_DCI_P3)
> +		pix->colorspace = V4L2_COLORSPACE_SRGB;
> +	if (pix->field == V4L2_FIELD_ANY)
> +		pix->field = V4L2_FIELD_NONE;
> +
> +	return 0;
> +}
> +
> +static int vcam_vidioc_querycap(struct file *file, void *priv,
> +				struct v4l2_capability *cap)
> +{
> +	__u32 capabilities = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
> +	struct vcam *dev = video_drvdata(file);
> +
> +	cap->device_caps = capabilities;
> +	cap->capabilities = capabilities | V4L2_CAP_DEVICE_CAPS;
> +
> +	strscpy(cap->driver, "vcam", sizeof(cap->driver));
> +	strscpy(cap->card, dev->vdev->name, sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "vcam:%d",
> +		 dev->device_nr);
> +
> +	return 0;
> +}
> +
> +static int vcam_enum_framesizes(struct vcam *dev, struct v4l2_frmsizeenum *argp)
> +{
> +	if (vcam_is_streaming(dev)) {
> +		if (argp->index)
> +			return -EINVAL;
> +		if (argp->pixel_format != dev->pix_format.pixelformat)
> +			return -EINVAL;
> +
> +		argp->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +
> +		argp->discrete.width = dev->pix_format.width;
> +		argp->discrete.height = dev->pix_format.height;
> +	} else {
> +		u32 width;
> +		u32 height;
> +
> +		if (!vcam_find_format(argp->pixel_format) ||
> +		    !vcam_mode_has_pixelformat(dev, argp->pixel_format))
> +			return -EINVAL;
> +
> +		if (vcam_mode_enum_framesize(dev, argp->pixel_format,
> +					     argp->index, &width, &height))
> +			return -EINVAL;
> +
> +		argp->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +		argp->discrete.width = width;
> +		argp->discrete.height = height;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vcam_enum_frameintervals(struct vcam *dev,
> +				    struct v4l2_frmivalenum *argp)
> +{
> +	if (vcam_is_streaming(dev)) {
> +		if (argp->index)
> +			return -EINVAL;
> +		if (argp->width != dev->pix_format.width ||
> +		    argp->height != dev->pix_format.height ||
> +		    argp->pixel_format != dev->pix_format.pixelformat)
> +			return -EINVAL;
> +
> +		argp->type = V4L2_FRMIVAL_TYPE_DISCRETE;
> +		argp->discrete = dev->capture.timeperframe;
> +	} else {
> +		if (!vcam_find_format(argp->pixel_format) ||
> +		    !vcam_mode_has_framesize(dev, argp->pixel_format,
> +					     argp->width, argp->height))
> +			return -EINVAL;
> +
> +		if (argp->index)
> +			return -EINVAL;
> +
> +		argp->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
> +		argp->stepwise.min.numerator = 1;
> +		argp->stepwise.min.denominator = VCAM_FPS_MAX;
> +		argp->stepwise.max.numerator = 1;
> +		argp->stepwise.max.denominator = VCAM_FPS_MIN;
> +		argp->stepwise.step.numerator = 1;
> +		argp->stepwise.step.denominator = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vcam_vidioc_enum_framesizes(struct file *file, void *fh,
> +				       struct v4l2_frmsizeenum *argp)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +
> +	return vcam_enum_framesizes(dev, argp);
> +}
> +
> +static int vcam_vidioc_enum_frameintervals(struct file *file, void *fh,
> +					   struct v4l2_frmivalenum *argp)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +
> +	return vcam_enum_frameintervals(dev, argp);
> +}
> +
> +static int vcam_vidioc_enum_fmt_cap(struct file *file, void *fh,
> +				    struct v4l2_fmtdesc *f)
> +{
> +	struct vcam *dev;
> +
> +	dev = video_drvdata(file);
> +
> +	if (vcam_is_streaming(dev)) {
> +		const __u32 format = dev->pix_format.pixelformat;
> +
> +		if (f->index)
> +			return -EINVAL;
> +
> +		f->pixelformat = dev->pix_format.pixelformat;
> +		vcam_fmt_descr(f->description, sizeof(f->description), format);
> +	} else {
> +		u32 pixelformat;
> +
> +		if (vcam_mode_enum_format(dev, f->index, &pixelformat))
> +			return -EINVAL;
> +
> +		f->pixelformat = pixelformat;
> +		vcam_fmt_descr(f->description, sizeof(f->description),
> +			       pixelformat);
> +	}
> +	f->flags = 0;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_g_fmt_vid_cap(struct file *file, void *priv,
> +				     struct v4l2_format *fmt)
> +{
> +	struct vcam *dev;
> +
> +	dev = video_drvdata(file);
> +
> +	fmt->fmt.pix = dev->pix_format;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_try_fmt_vid_cap(struct file *file, void *priv,
> +				       struct v4l2_format *fmt)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +	struct v4l2_format try_fmt;
> +	int ret;
> +
> +	if (!V4L2_TYPE_IS_CAPTURE(fmt->type))
> +		return -EINVAL;
> +
> +	if (vcam_is_streaming(dev)) {
> +		if (!vcam_pix_format_eq(&dev->pix_format, &fmt->fmt.pix))
> +			return -EBUSY;
> +
> +		fmt->fmt.pix = dev->pix_format;
> +	}
> +
> +	try_fmt = *fmt;
> +	ret = vcam_set_format(&try_fmt);
> +	if (ret)
> +		return ret;
> +	if (!vcam_mode_allowed(dev, &try_fmt.fmt.pix))
> +		return -EINVAL;
> +	*fmt = try_fmt;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_s_fmt_vid_cap(struct file *file, void *priv,
> +				     struct v4l2_format *fmt)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +	struct v4l2_format try_fmt = *fmt;
> +	int ret;
> +
> +	if (!V4L2_TYPE_IS_CAPTURE(fmt->type))
> +		return -EINVAL;
> +
> +	if (vcam_is_streaming(dev)) {
> +		if (!vcam_pix_format_eq(&dev->pix_format, &fmt->fmt.pix))
> +			return -EBUSY;
> +
> +		fmt->fmt.pix = dev->pix_format;
> +	}
> +
> +	ret = vcam_set_format(&try_fmt);
> +	if (ret)
> +		return ret;
> +
> +	if (!vcam_mode_allowed(dev, &try_fmt.fmt.pix))
> +		return -EINVAL;
> +
> +	if (vb2_is_busy(&dev->output_queue) &&
> +	    !vcam_pix_format_eq(&dev->pix_format, &try_fmt.fmt.pix))
> +		return -EBUSY;
> +
> +	dev->pix_format = try_fmt.fmt.pix;
> +	*fmt = try_fmt;
> +	return 0;
> +}
> +
> +static int vcam_ioc_reqbufs(struct file *file, struct vcam *dev,
> +			    struct v4l2_requestbuffers *req)
> +{
> +	int ret = 0;
> +
> +	if (req->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &dev->lock)
> +	{
> +		if (vb2_queue_is_busy(&dev->output_queue, file)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		ret = vb2_reqbufs(&dev->output_queue, req);
> +		if (!ret)
> +			dev->output_queue.owner =
> +				req->count ? file->private_data : NULL;
> +	}
> +	return ret;
> +}
> +
> +static int vcam_ioc_querybuf(struct file *file, struct vcam *dev,
> +			     struct v4l2_buffer *buf)
> +{
> +	int ret = 0;
> +
> +	if (buf->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &dev->lock)
> +		ret = vb2_querybuf(&dev->output_queue, buf);
> +
> +	return ret;
> +}
> +
> +static ssize_t formats_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct vcam_format_entry {
> +		u32 fourcc;
> +		char name[5];
> +	};
> +	struct vcam_format_entry formats[VCAM_MAX_FORMATS];
> +	struct vcam_format_entry tmp;
> +	unsigned int count =
> +		min_t(unsigned int, VCAM_NR_FORMATS, VCAM_MAX_FORMATS);
> +	size_t len = 0;
> +	unsigned int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		formats[i].fourcc = vcam_formats[i].fourcc;
> +		vcam_fourcc_str(formats[i].name, formats[i].fourcc);
> +	}
> +
> +	for (i = 1; i < count; i++) {
> +		for (j = i; j > 0; j--) {
> +			if (strcmp(formats[j - 1].name, formats[j].name) <= 0)
> +				break;
> +			tmp = formats[j - 1];
> +			formats[j - 1] = formats[j];
> +			formats[j] = tmp;
> +		}
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		len += sysfs_emit_at(buf, len, "%s%s", i ? " " : "",
> +				     formats[i].name);
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +	return len;
> +}
> +
> +static ssize_t max_width_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", VCAM_MAX_WIDTH);
> +}
> +
> +static ssize_t max_height_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", VCAM_MAX_HEIGHT);
> +}
> +
> +static ssize_t max_frames_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", VCAM_MAX_FRAMES);
> +}
> +
> +static DEVICE_ATTR_RO(formats);
> +static DEVICE_ATTR_RO(max_frames);
> +static DEVICE_ATTR_RO(max_height);
> +static DEVICE_ATTR_RO(max_width);
> +
> +static struct attribute *vcam_attrs[] = {
> +	&dev_attr_formats.attr,
> +	&dev_attr_max_frames.attr,
> +	&dev_attr_max_height.attr,
> +	&dev_attr_max_width.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vcam_attr_group = {
> +	.attrs = vcam_attrs,
> +};
> +
> +static const struct attribute_group *vcam_attr_groups[] = {
> +	&vcam_attr_group,
> +	NULL,
> +};
> +
> +static int vcam_ioc_alloc(struct file *file, struct vcam *dev, u32 nr_frames,
> +			  void __user *frames_user, enum vb2_memory memory)
> +{
> +	struct v4l2_requestbuffers req = {
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +		.memory = memory,
> +	};
> +	struct v4l2_buffer buf;
> +	struct vcam_frame *frames = NULL;
> +	unsigned int i;
> +	int ret;
> +
> +	if (memory == VB2_MEMORY_DMABUF &&
> +	    !dev->output_queue.mem_ops->attach_dmabuf)
> +		return -EOPNOTSUPP;
> +
> +	if (!frames_user)
> +		return -EINVAL;
> +
> +	if (nr_frames) {
> +		frames = kcalloc(nr_frames, sizeof(*frames), GFP_KERNEL);
> +		if (!frames)
> +			return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(frames, frames_user, nr_frames * sizeof(*frames))) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	req.count = nr_frames;
> +	ret = vcam_ioc_reqbufs(file, dev, &req);
> +	if (ret)
> +		goto out_free;
> +
> +	if (req.count != nr_frames) {
> +		struct v4l2_requestbuffers req_free = {
> +			.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +			.memory = memory,
> +			.count = 0,
> +		};
> +
> +		vcam_ioc_reqbufs(file, dev, &req_free);
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	dev->output_memory = memory;
> +
> +	for (i = 0; i < nr_frames; i++) {
> +		memset(&buf, 0, sizeof(buf));
> +		buf.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +		buf.memory = memory;
> +		buf.index = i;
> +
> +		ret = vcam_ioc_querybuf(file, dev, &buf);
> +		if (ret)
> +			goto out_free_reqbufs;
> +
> +		frames[i].index = i;
> +		frames[i].length = buf.length;
> +	}
> +
> +	if (copy_to_user(frames_user, frames, nr_frames * sizeof(*frames)))
> +		ret = -EFAULT;
> +
> +out_free_reqbufs:
> +	if (ret) {
> +		struct v4l2_requestbuffers req_free = {
> +			.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +			.memory = memory,
> +			.count = 0,
> +		};
> +
> +		vcam_ioc_reqbufs(file, dev, &req_free);
> +		dev->output_memory = VB2_MEMORY_DMABUF;
> +	}
> +out_free:
> +	kfree(frames);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int vcam_ioc_queue(struct file *file, struct vcam *dev,
> +			  struct vcam_ioc_queue *queue)
> +{
> +	struct v4l2_buffer buf = {
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +		.memory = dev->output_memory,
> +		.index = queue->index,
> +		.bytesused = queue->length,
> +	};
> +	u32 remainder;
> +	int ret;
> +
> +	if (queue->reserved)
> +		return -EINVAL;
> +
> +	if (dev->output_memory == VB2_MEMORY_DMABUF) {
> +		buf.m.fd = queue->fd;
> +		buf.length = dev->pix_format.sizeimage;
> +	}
> +
> +	buf.timestamp.tv_sec =
> +		div_u64_rem(queue->timestamp, NSEC_PER_SEC, &remainder);
> +	buf.timestamp.tv_usec = remainder / NSEC_PER_USEC;
> +
> +	scoped_guard(mutex, &dev->lock)
> +	{
> +		if (vb2_queue_is_busy(&dev->output_queue, file)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		if (vb2_is_streaming(&dev->capture_queue) &&
> +		    !vb2_is_streaming(&dev->output_queue)) {
> +			ret = vb2_streamon(&dev->output_queue, buf.type);
> +			if (ret)
> +				break;
> +		}
> +
> +		ret = vb2_qbuf(&dev->output_queue, NULL, &buf);
> +	}
> +
> +	return ret;
> +}
> +
> +static int vcam_ioc_dequeue(struct file *file, struct vcam *dev,
> +			    struct vcam_ioc_dequeue *queue)
> +{
> +	struct v4l2_buffer buf = {
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +		.memory = dev->output_memory,
> +	};
> +	int ret;
> +
> +	scoped_guard(mutex, &dev->lock)
> +	{
> +		if (vb2_queue_is_busy(&dev->output_queue, file)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		ret = vb2_dqbuf(&dev->output_queue, &buf,
> +				file->f_flags & O_NONBLOCK);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	queue->index = buf.index;
> +	queue->length = buf.bytesused;
> +	queue->timestamp = (u64)buf.timestamp.tv_sec * NSEC_PER_SEC +
> +			   (u64)buf.timestamp.tv_usec * NSEC_PER_USEC;
> +	return 0;
> +}
> +
> +static int vcam_ioc_wait(struct vcam *dev, struct vcam_ioc_wait *wait)
> +{
> +	const struct v4l2_pix_format *pix = &dev->pix_format;
> +	struct vcam_mode mode;
> +	int ret;
> +
> +	if (wait->reserved)
> +		return -EINVAL;
> +
> +	if (wait->mask & ~VCAM_STATUS_MASK)
> +		return -EINVAL;
> +
> +	if (!wait->mode)
> +		return -EINVAL;
> +
> +	if (wait->mask) {
> +		ret = wait_event_interruptible(dev->status_waitq,
> +					       vcam_status_mask_ready(dev,
> +								      wait->mask));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	wait->status = vcam_status_read(dev);
> +	mode = (struct vcam_mode){
> +		.width = pix->width,
> +		.height = pix->height,
> +		.pixelformat = pix->pixelformat,
> +		.colorspace = pix->colorspace,
> +		.stride = pix->bytesperline,
> +	};
> +
> +	if (copy_to_user(u64_to_user_ptr(wait->mode), &mode, sizeof(mode)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static long vcam_output_ioctl_core(struct file *file, unsigned int cmd,
> +				   void *arg)
> +{
> +	struct vcam *dev = file->private_data;
> +	long ret = 0;
> +
> +	switch (cmd) {
> +	case VCAM_IOC_QUEUE:
> +		ret = vcam_ioc_queue(file, dev, arg);
> +		break;
> +	case VCAM_IOC_DEQUEUE:
> +		ret = vcam_ioc_dequeue(file, dev, arg);
> +		break;
> +	case VCAM_IOC_WAIT:
> +		ret = vcam_ioc_wait(dev, arg);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static long vcam_ioctl_common(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	void *karg;
> +	size_t size;
> +	long ret;
> +
> +	switch (cmd) {
> +	case VCAM_IOC_QUEUE:
> +		size = sizeof(struct vcam_ioc_queue);
> +		break;
> +	case VCAM_IOC_DEQUEUE:
> +		size = sizeof(struct vcam_ioc_dequeue);
> +		break;
> +	case VCAM_IOC_WAIT:
> +		size = sizeof(struct vcam_ioc_wait);
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	if (size > SZ_4K)
> +		return -ENOTTY;
> +
> +	karg = kzalloc(size, GFP_KERNEL);
> +	if (!karg)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(karg, argp, size)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	ret = vcam_output_ioctl_core(file, cmd, karg);
> +	if (ret)
> +		goto out_free;
> +
> +	if (copy_to_user(argp, karg, size)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	ret = 0;
> +out_free:
> +	kfree(karg);
> +	return ret;
> +}
> +
> +static void __vcam_release(struct vcam *dev)
> +{
> +	if (!dev->vdev)
> +		return;
> +
> +	vb2_queue_release(&dev->output_queue);
> +	vb2_queue_release(&dev->capture_queue);
> +	kfree(dev->modes);
> +	dev->modes = NULL;
> +	dev->nr_modes = 0;
> +
> +	if (video_is_registered(dev->vdev))
> +		video_unregister_device(dev->vdev);
> +	else
> +		video_device_release(dev->vdev);
> +
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +
> +	dev->vdev = NULL;
> +	dev->device_nr = -1;
> +}
> +
> +static void vcam_release(struct kref *ref)
> +{
> +	struct vcam *dev;
> +
> +	dev = container_of(ref, struct vcam, ref);
> +
> +	if (!test_bit(VCAM_FLAG_CREATING, &dev->flags) || dev->device_nr < 0) {
> +		kfree(dev);
> +		return;
> +	}
> +
> +	__vcam_release(dev);
> +	kfree(dev);
> +}
> +
> +static int __vcam_close(struct inode *inode, struct file *file)
> +{
> +	struct vcam *dev = file->private_data;
> +
> +	if (dev->vdev && video_is_registered(dev->vdev))
> +		video_unregister_device(dev->vdev);
> +
> +	vb2_queue_release(&dev->output_queue);
> +
> +	dev->output_memory = VB2_MEMORY_DMABUF;
> +	kfree(dev->modes);
> +	dev->modes = NULL;
> +	dev->nr_modes = 0;
> +
> +	kref_put(&dev->ref, vcam_release);
> +	return 0;
> +}
> +
> +static int vcam_open(struct inode *inode, struct file *file)
> +{
> +	struct vcam *dev;
> +	int ret = nonseekable_open(inode, file);
> +
> +	if (ret)
> +		return ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	kref_init(&dev->ref);
> +	dev->device_nr = -1;
> +	file->private_data = dev;
> +	return 0;
> +}
> +
> +static int vcam_close(struct inode *inode, struct file *file)
> +{
> +	struct vcam *dev = file->private_data;
> +	int ret = 0;
> +
> +	if (!dev)
> +		return 0;
> +
> +	if (test_bit(VCAM_FLAG_CREATING, &dev->flags) && dev->device_nr >= 0)
> +		ret = __vcam_close(inode, file);
> +	else
> +		kref_put(&dev->ref, vcam_release);
> +
> +	file->private_data = NULL;
> +	return ret;
> +}
> +
> +static __poll_t vcam_poll(struct file *file, struct poll_table_struct *pts)
> +{
> +	struct vcam *dev = file->private_data;
> +
> +	if (!dev || !test_bit(VCAM_FLAG_CREATING, &dev->flags) ||
> +	    !test_bit(VCAM_FLAG_READY, &dev->flags) || dev->device_nr < 0)
> +		return POLLERR;
> +
> +	return vb2_core_poll(&dev->output_queue, file, pts);
> +}
> +
> +static int vcam_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vcam *dev = file->private_data;
> +
> +	if (!dev || !test_bit(VCAM_FLAG_CREATING, &dev->flags) ||
> +	    !test_bit(VCAM_FLAG_READY, &dev->flags) || dev->device_nr < 0)
> +		return -ENOTTY;
> +
> +	return vb2_mmap(&dev->output_queue, vma);
> +}
> +
> +static int vcam_vidioc_g_parm(struct file *file, void *priv,
> +			      struct v4l2_streamparm *parm)
> +{
> +	struct vcam *dev;
> +
> +	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	dev = video_drvdata(file);
> +	parm->parm.capture = dev->capture;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_s_parm(struct file *file, void *priv,
> +			      struct v4l2_streamparm *parm)
> +{
> +	struct v4l2_fract *tpf = &parm->parm.capture.timeperframe;
> +	struct vcam *dev = video_drvdata(file);
> +
> +	if (!vcam_tpf_valid(tpf))
> +		return -EINVAL;
> +
> +	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	dev->capture.timeperframe = *tpf;
> +	parm->parm.capture = dev->capture;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_enum_input(struct file *file, void *fh,
> +				  struct v4l2_input *inp)
> +{
> +	struct vcam *dev;
> +	__u32 index = inp->index;
> +
> +	if (index != 0)
> +		return -EINVAL;
> +
> +	memset(inp, 0, sizeof(*inp));
> +
> +	inp->index = index;
> +	strscpy(inp->name, "vcam", sizeof(inp->name));
> +	inp->type = V4L2_INPUT_TYPE_CAMERA;
> +	inp->audioset = 0;
> +	inp->tuner = 0;
> +	inp->status = 0;
> +
> +	dev = video_drvdata(file);
> +	if (!vb2_is_streaming(&dev->output_queue))
> +		inp->status |= V4L2_IN_ST_NO_SIGNAL;
> +
> +	return 0;
> +}
> +
> +static int vcam_vidioc_g_input(struct file *file, void *fh, unsigned int *i)
> +{
> +	*i = 0;
> +	return 0;
> +}
> +
> +static int vcam_vidioc_s_input(struct file *file, void *fh, unsigned int i)
> +{
> +	if (i == 0)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int vcam_vidioc_streamon(struct file *file, void *fh,
> +				enum v4l2_buf_type type)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +	int ret;
> +
> +	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	if (vb2_queue_is_busy(&dev->capture_queue, file))
> +		return -EBUSY;
> +
> +	ret = vb2_streamon(&dev->capture_queue, type);
> +	if (ret)
> +		return ret;
> +
> +	if (vb2_get_num_buffers(&dev->output_queue)) {
> +		ret = vb2_streamon(&dev->output_queue,
> +				   V4L2_BUF_TYPE_VIDEO_OUTPUT);
> +		if (ret) {
> +			vb2_streamoff(&dev->capture_queue, type);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int vcam_vidioc_streamoff(struct file *file, void *fh,
> +				 enum v4l2_buf_type type)
> +{
> +	struct vcam *dev = video_drvdata(file);
> +	int ret;
> +
> +	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	if (vb2_queue_is_busy(&dev->capture_queue, file))
> +		return -EBUSY;
> +
> +	ret = vb2_streamoff(&dev->capture_queue, type);
> +	if (ret)
> +		return ret;
> +
> +	if (vb2_get_num_buffers(&dev->output_queue))
> +		vb2_streamoff(&dev->output_queue, V4L2_BUF_TYPE_VIDEO_OUTPUT);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops vcam_ioctl_ops = {
> +	.vidioc_querycap = &vcam_vidioc_querycap,
> +	.vidioc_enum_framesizes = &vcam_vidioc_enum_framesizes,
> +	.vidioc_enum_frameintervals = &vcam_vidioc_enum_frameintervals,
> +	.vidioc_enum_input = &vcam_vidioc_enum_input,
> +	.vidioc_g_input = &vcam_vidioc_g_input,
> +	.vidioc_s_input = &vcam_vidioc_s_input,
> +	.vidioc_enum_fmt_vid_cap = &vcam_vidioc_enum_fmt_cap,
> +	.vidioc_g_fmt_vid_cap = &vcam_vidioc_g_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap = &vcam_vidioc_s_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap = &vcam_vidioc_try_fmt_vid_cap,
> +	.vidioc_g_parm = &vcam_vidioc_g_parm,
> +	.vidioc_s_parm = &vcam_vidioc_s_parm,
> +
> +	.vidioc_reqbufs = &vb2_ioctl_reqbufs,
> +	.vidioc_create_bufs = &vb2_ioctl_create_bufs,
> +	.vidioc_prepare_buf = &vb2_ioctl_prepare_buf,
> +	.vidioc_querybuf = &vb2_ioctl_querybuf,
> +	.vidioc_qbuf = &vb2_ioctl_qbuf,
> +	.vidioc_dqbuf = &vb2_ioctl_dqbuf,
> +	.vidioc_expbuf = &vb2_ioctl_expbuf,
> +	.vidioc_streamon = &vcam_vidioc_streamon,
> +	.vidioc_streamoff = &vcam_vidioc_streamoff,
> +};
> +
> +static enum vb2_buffer_state vcam_buf_fill(struct vcam *dev,
> +					   struct vcam_buf *buf,
> +					   const void *src, u32 src_len,
> +					   u64 timestamp)
> +{
> +	struct vb2_buffer *vb = &buf->vb.vb2_buf;
> +	u32 sequence;
> +	void *dst;
> +
> +	dst = vb2_plane_vaddr(vb, 0);
> +	if (!dst)
> +		return VB2_BUF_STATE_ERROR;
> +
> +	if (!src_len || src_len > dev->pix_format.sizeimage)
> +		src_len = dev->pix_format.sizeimage;
> +
> +	if (!src)
> +		return VB2_BUF_STATE_ERROR;
> +
> +	memcpy(dst, src, src_len);
> +
> +	sequence = (u32)(atomic_inc_return(&dev->sequence) - 1);
> +
> +	vb->timestamp = timestamp ? timestamp : ktime_get_ns();
> +	buf->vb.sequence = sequence;
> +	buf->vb.field = dev->pix_format.field;
> +	vb2_set_plane_payload(vb, 0, src_len);
> +
> +	return VB2_BUF_STATE_DONE;
> +}
> +
> +static bool vcam_buf_flip(struct vcam *dev, struct vb2_buffer *out_vb,
> +			  struct vcam_buf *cap_buf, u32 bytesused)
> +{
> +	struct vb2_buffer *cap_vb = &cap_buf->vb.vb2_buf;
> +	u32 sequence;
> +
> +	if (!out_vb->planes[0].dbuf || !cap_vb->planes[0].dbuf)
> +		return false;
> +
> +	if (out_vb->planes[0].dbuf != cap_vb->planes[0].dbuf)
> +		return false;
> +
> +	if (!bytesused)
> +		bytesused = dev->pix_format.sizeimage;
> +	if (bytesused > vb2_plane_size(cap_vb, 0))
> +		bytesused = vb2_plane_size(cap_vb, 0);
> +
> +	sequence = (u32)(atomic_inc_return(&dev->sequence) - 1);
> +
> +	cap_vb->timestamp = out_vb->timestamp ? out_vb->timestamp :
> +						ktime_get_ns();
> +	cap_buf->vb.sequence = sequence;
> +	cap_buf->vb.field = dev->pix_format.field;
> +	vb2_set_plane_payload(cap_vb, 0, bytesused);
> +
> +	return true;
> +}
> +
> +static bool vcam_buf_pair_dequeue(struct vcam *dev, struct vcam_buf **out_buf,
> +				  struct vcam_buf **cap_buf)
> +{
> +	unsigned long flags;
> +	bool dequeued = false;
> +
> +	spin_lock_irqsave(&dev->frame_lock, flags);
> +	if (!list_empty(&dev->output_list) && !list_empty(&dev->capture_list)) {
> +		*out_buf = list_first_entry(&dev->output_list, struct vcam_buf,
> +					    list);
> +		list_del(&(*out_buf)->list);
> +		*cap_buf = list_first_entry(&dev->capture_list, struct vcam_buf,
> +					    list);
> +		list_del(&(*cap_buf)->list);
> +		dequeued = true;
> +	}
> +	spin_unlock_irqrestore(&dev->frame_lock, flags);
> +	return dequeued;
> +}
> +
> +static void vcam_dequeue_frames(struct vcam *data)
> +{
> +	const struct vcam_format *format;
> +	enum vb2_buffer_state cap_state;
> +	struct vcam_buf *cap_buf;
> +	struct vcam_buf *out_buf;
> +	struct vb2_buffer *vb;
> +	bool zero_copy;
> +	u32 bytesused;
> +	void *src;
> +
> +	if (!vcam_is_streaming(data))
> +		return;
> +
> +	format = vcam_find_format(data->pix_format.pixelformat);
> +	while (vcam_buf_pair_dequeue(data, &out_buf, &cap_buf)) {
> +		cap_state = VB2_BUF_STATE_DONE;
> +		vb = &out_buf->vb.vb2_buf;
> +		bytesused = vb2_get_plane_payload(vb, 0);
> +		if (!bytesused || bytesused > data->pix_format.sizeimage)
> +			bytesused = data->pix_format.sizeimage;
> +
> +		if (bytesused < data->pix_format.sizeimage &&
> +		    (!format || !(format->flags & VCAM_COMPRESSED))) {
> +			cap_state = VB2_BUF_STATE_ERROR;
> +			goto out_done;
> +		}
> +
> +		zero_copy = vcam_buf_flip(data, vb, cap_buf, bytesused);
> +		if (!zero_copy &&
> +		    (!(out_buf->flags & VCAM_BUF_FLAG_MAPPABLE) ||
> +		     !(cap_buf->flags & VCAM_BUF_FLAG_MAPPABLE))) {
> +			dev_dbg(&data->vdev->dev,
> +				"unshared unmappable capture and output");
> +			cap_state = VB2_BUF_STATE_ERROR;
> +			goto out_done;
> +		}
> +		if (!zero_copy) {
> +			src = vb2_plane_vaddr(vb, 0);
> +			if (!src) {
> +				cap_state = VB2_BUF_STATE_ERROR;
> +				goto out_done;
> +			}
> +
> +			cap_state = vcam_buf_fill(data, cap_buf, src, bytesused,
> +						  vb->timestamp);
> +		}
> +out_done:
> +		vb2_buffer_done(&cap_buf->vb.vb2_buf, cap_state);
> +
> +		if (cap_state == VB2_BUF_STATE_ERROR)
> +			vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
> +		else
> +			vb2_buffer_done(vb, VB2_BUF_STATE_DONE);
> +	}
> +}
> +
> +static int vcam_vdev_open(struct file *file)
> +{
> +	struct vcam *dev;
> +	int ret;
> +
> +	dev = video_drvdata(file);
> +	if (test_and_set_bit(VCAM_FLAG_IS_OPEN, &dev->flags))
> +		return -EBUSY;
> +	if (dev->device_nr < 0 || !test_bit(VCAM_FLAG_READY, &dev->flags)) {
> +		clear_bit(VCAM_FLAG_IS_OPEN, &dev->flags);
> +		return -ENODEV;
> +	}
> +
> +	ret = v4l2_fh_open(file);
> +	if (ret) {
> +		clear_bit(VCAM_FLAG_IS_OPEN, &dev->flags);
> +		return ret;
> +	}
> +
> +	kref_get(&dev->ref);
> +	return 0;
> +}
> +
> +static int vcam_vdev_close(struct file *file)
> +{
> +	struct vcam *dev;
> +	int ret;
> +
> +	dev = video_drvdata(file);
> +	ret = _vb2_fop_release(file, NULL);
> +	clear_bit(VCAM_FLAG_IS_OPEN, &dev->flags);
> +
> +	kref_put(&dev->ref, vcam_release);
> +	return ret;
> +}
> +
> +static const struct v4l2_file_operations vcam_vdev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = vcam_vdev_open,
> +	.release = vcam_vdev_close,
> +	.poll = vb2_fop_poll,
> +	.mmap = vb2_fop_mmap,
> +	.unlocked_ioctl = video_ioctl2,
> +};
> +
> +static int vcam_ioc_create_validate(struct vcam_ioc_create *config,
> +				    char *card_label)
> +{
> +	long len, i;
> +
> +	if (config->device_nr != 0)
> +		return -EINVAL;
> +	if (config->reserved)
> +		return -EINVAL;
> +	if (!config->nr_modes || config->nr_modes > VCAM_MAX_MODES)
> +		return -EINVAL;
> +	if (!config->modes)
> +		return -EINVAL;
> +	if (config->nr_frames > VCAM_MAX_FRAMES)
> +		return -E2BIG;
> +	if (config->nr_frames < VCAM_MIN_FRAMES)
> +		return -EINVAL;
> +	if (!config->frames)
> +		return -EINVAL;
> +
> +	memset(card_label, 0, VCAM_CARD_LABEL_MAX);
> +	len = strncpy_from_user(card_label,
> +				u64_to_user_ptr(config->device_name),
> +				VCAM_CARD_LABEL_MAX);
> +	if (len < 0)
> +		return -EFAULT;
> +	if (len >= VCAM_CARD_LABEL_MAX)
> +		return -E2BIG;
> +	if (!len)
> +		return -EINVAL;
> +	if (!isalnum((unsigned char)card_label[0]))
> +		return -EINVAL;
> +	for (i = 0; i < len; i++) {
> +		if (!isalnum((unsigned char)card_label[i]) &&
> +		    !isspace((unsigned char)card_label[i]))
> +			return -EINVAL;
> +	}
> +	if (!isalnum((unsigned char)card_label[len - 1]))
> +		return -EINVAL;
> +
> +	return len;
> +}
> +
> +static int vcam_vb2_queue_setup(struct vb2_queue *queue,
> +				unsigned int *nr_buffers,
> +				unsigned int *nr_planes, unsigned int sizes[],
> +				struct device *alloc_devs[])
> +{
> +	struct vcam *data = vb2_get_drv_priv(queue);
> +	unsigned int sizeimage = data->pix_format.sizeimage;
> +
> +	if (!sizeimage)
> +		return -EINVAL;
> +
> +	if (*nr_buffers < VCAM_MIN_FRAMES)
> +		*nr_buffers = VCAM_MIN_FRAMES;
> +	if (*nr_buffers > VCAM_MAX_FRAMES)
> +		*nr_buffers = VCAM_MAX_FRAMES;
> +
> +	if (*nr_planes)
> +		return sizes[0] < sizeimage ? -EINVAL : 0;
> +
> +	*nr_planes = 1;
> +	sizes[0] = sizeimage;
> +	return 0;
> +}
> +
> +static int vcam_vb2_buf_prepare(struct vb2_buffer *vb)
> +{
> +	struct vcam *data = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct vcam_buf *buf = container_of(vbuf, struct vcam_buf, vb);
> +	unsigned int sizeimage = data->pix_format.sizeimage;
> +	unsigned int bytesused;
> +	void *vaddr;
> +
> +	if (vb2_plane_size(vb, 0) < sizeimage)
> +		return -EINVAL;
> +
> +	vbuf->field = data->pix_format.field;
> +	bytesused = vb2_get_plane_payload(vb, 0);
> +	if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type) && !bytesused)
> +		vb2_set_plane_payload(vb, 0, sizeimage);
> +
> +	buf->flags = VCAM_BUF_FLAG_MAPPABLE;
> +	if (vb->planes[0].dbuf) {
> +		vaddr = vb2_plane_vaddr(vb, 0);
> +		if (!vaddr)
> +			buf->flags &= ~VCAM_BUF_FLAG_MAPPABLE;
> +	}
> +	return 0;
> +}
> +
> +static void vcam_vb2_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vcam *data = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct vcam_buf *buf;
> +	unsigned long flags;
> +
> +	buf = container_of(vbuf, struct vcam_buf, vb);
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
> +		spin_lock_irqsave(&data->frame_lock, flags);
> +		list_add_tail(&buf->list, &data->output_list);
> +		spin_unlock_irqrestore(&data->frame_lock, flags);
> +	} else {
> +		spin_lock_irqsave(&data->frame_lock, flags);
> +		list_add_tail(&buf->list, &data->capture_list);
> +		spin_unlock_irqrestore(&data->frame_lock, flags);
> +	}
> +
> +	vcam_dequeue_frames(data);
> +}
> +
> +static int vcam_vb2_prepare_streaming(struct vb2_queue *vq)
> +{
> +	return 0;
> +}
> +
> +static int vcam_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
> +{
> +	struct vcam *data = vb2_get_drv_priv(vq);
> +
> +	if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
> +		atomic_set(&data->sequence, 0);
> +		vcam_status_update_stream(data, true);
> +	}
> +
> +	vcam_dequeue_frames(data);
> +	return 0;
> +}
> +
> +static void vcam_vb2_stop_streaming(struct vb2_queue *vq)
> +{
> +	struct vcam *data = vb2_get_drv_priv(vq);
> +	struct vcam_buf *buf, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(done_list);
> +
> +	if (V4L2_TYPE_IS_CAPTURE(vq->type))
> +		vcam_status_update_stream(data, false);
> +
> +	spin_lock_irqsave(&data->frame_lock, flags);
> +	list_splice_init(&data->output_list, &done_list);
> +	list_splice_init(&data->capture_list, &done_list);
> +	spin_unlock_irqrestore(&data->frame_lock, flags);
> +
> +	list_for_each_entry_safe(buf, tmp, &done_list, list)
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +}
> +
> +static const struct vb2_ops vcam_vb2_ops = {
> +	.queue_setup = vcam_vb2_queue_setup,
> +	.buf_queue = vcam_vb2_buf_queue,
> +	.buf_prepare = vcam_vb2_buf_prepare,
> +	.prepare_streaming = vcam_vb2_prepare_streaming,
> +	.start_streaming = vcam_vb2_start_streaming,
> +	.stop_streaming = vcam_vb2_stop_streaming,
> +};
> +
> +static int vcam_ioc_create(struct file *file, struct vcam *dev,
> +			   struct vcam_ioc_create *config, char *card_label,
> +			   unsigned int len)
> +{
> +	struct vcam_mode *modes = NULL;
> +	struct v4l2_format try_fmt;
> +	struct video_device *vdev;
> +	struct vb2_queue *queue;
> +	struct v4l2_format fmt;
> +	long ret;
> +	u32 i;
> +
> +	strscpy(dev->v4l2_dev.name, "vcam", sizeof(dev->v4l2_dev.name));
> +
> +	ret = v4l2_device_register(NULL, &dev->v4l2_dev);
> +	if (ret)
> +		return ret;
> +
> +	vdev = video_device_alloc();
> +	if (!vdev) {
> +		ret = -ENOMEM;
> +		goto err_unregister;
> +	}
> +
> +	dev->vdev = vdev;
> +	video_set_drvdata(vdev, dev);
> +	memcpy(vdev->name, card_label, len);
> +	vdev->name[len] = '\0';
> +	vdev->vfl_type = VFL_TYPE_VIDEO;
> +	vdev->fops = &vcam_vdev_fops;
> +	vdev->ioctl_ops = &vcam_ioctl_ops;
> +	vdev->release = &video_device_release;
> +	vdev->minor = -1;
> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	vdev->vfl_dir = VFL_DIR_RX;
> +
> +	mutex_init(&dev->lock);
> +	spin_lock_init(&dev->frame_lock);
> +	spin_lock_init(&dev->status_lock);
> +	INIT_LIST_HEAD(&dev->capture_list);
> +	INIT_LIST_HEAD(&dev->output_list);
> +	dev->status = VCAM_STATUS_IDLE;
> +	dev->output_memory = VB2_MEMORY_DMABUF;
> +	init_waitqueue_head(&dev->status_waitq);
> +
> +	dev->vdev->v4l2_dev = &dev->v4l2_dev;
> +	dev->vdev->queue = &dev->capture_queue;
> +	dev->vdev->lock = &dev->lock;
> +	dev->capture.capability = 0;
> +	dev->capture.capturemode = 0;
> +	dev->capture.extendedmode = 0;
> +	dev->capture.readbuffers = VCAM_MIN_FRAMES;
> +	dev->capture.timeperframe.numerator = 1;
> +	dev->capture.timeperframe.denominator = 30;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER) ||
> +	    !vb2_vmalloc_memops.attach_dmabuf) {
> +		ret = -EOPNOTSUPP;
> +		goto err_unregister;
> +	}
> +
> +	modes = kcalloc(config->nr_modes, sizeof(*modes), GFP_KERNEL);
> +	if (!modes) {
> +		ret = -ENOMEM;
> +		goto err_unregister;
> +	}
> +
> +	if (copy_from_user(modes, u64_to_user_ptr(config->modes),
> +			   config->nr_modes * sizeof(*modes))) {
> +		ret = -EFAULT;
> +		goto err_modes;
> +	}
> +
> +	for (i = 0; i < config->nr_modes; i++) {
> +		struct vcam_mode *mode = &modes[i];
> +
> +		if (!mode->width || !mode->height || !mode->pixelformat) {
> +			ret = -EINVAL;
> +			goto err_modes;
> +		}
> +
> +		if (memchr_inv(mode->reserved, 0, sizeof(mode->reserved))) {
> +			ret = -EINVAL;
> +			goto err_modes;
> +		}
> +
> +		fmt = (struct v4l2_format){
> +			.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +			.fmt.pix = { .width = mode->width,
> +				     .height = mode->height,
> +				     .pixelformat = mode->pixelformat,
> +				     .colorspace = mode->colorspace,
> +				     .bytesperline = mode->stride,
> +				     .field = V4L2_FIELD_NONE }
> +		};
> +
> +		try_fmt = fmt;
> +		ret = vcam_set_format(&try_fmt);
> +		if (ret)
> +			goto err_modes;
> +
> +		if (try_fmt.fmt.pix.width != mode->width ||
> +		    try_fmt.fmt.pix.height != mode->height ||
> +		    try_fmt.fmt.pix.pixelformat != mode->pixelformat ||
> +		    (mode->colorspace != V4L2_COLORSPACE_DEFAULT &&
> +		     try_fmt.fmt.pix.colorspace != mode->colorspace) ||
> +		    (mode->stride &&
> +		     try_fmt.fmt.pix.bytesperline != mode->stride)) {
> +			ret = -EINVAL;
> +			goto err_modes;
> +		}
> +
> +		mode->colorspace = try_fmt.fmt.pix.colorspace;
> +		mode->stride = try_fmt.fmt.pix.bytesperline;
> +	}
> +
> +	sort(modes, config->nr_modes, sizeof(*modes), vcam_mode_cmp, NULL);
> +	for (i = 1; i < config->nr_modes; i++) {
> +		if (vcam_mode_equal(&modes[i - 1], &modes[i])) {
> +			ret = -EINVAL;
> +			goto err_modes;
> +		}
> +	}
> +
> +	dev->modes = modes;
> +	dev->nr_modes = config->nr_modes;
> +	modes = NULL;
> +	dev->pix_format = (struct v4l2_pix_format){
> +		.width = dev->modes[0].width,
> +		.height = dev->modes[0].height,
> +		.pixelformat = dev->modes[0].pixelformat,
> +		.colorspace = dev->modes[0].colorspace,
> +		.bytesperline = dev->modes[0].stride,
> +		.field = V4L2_FIELD_NONE,
> +	};
> +
> +	fmt = (struct v4l2_format){
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT,
> +		.fmt.pix = dev->pix_format,
> +	};
> +
> +	ret = vcam_set_format(&fmt);
> +	if (ret)
> +		goto err_unregister;
> +
> +	dev->pix_format = fmt.fmt.pix;
> +
> +	queue = &dev->capture_queue;
> +	queue->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	queue->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
> +	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	queue->drv_priv = dev;
> +	queue->buf_struct_size = sizeof(struct vcam_buf);
> +	queue->ops = &vcam_vb2_ops;
> +	queue->mem_ops = &vb2_vmalloc_memops;
> +	queue->lock = &dev->lock;
> +	queue->dev = &dev->vdev->dev;
> +	ret = vb2_queue_init(queue);
> +	if (ret)
> +		goto err_unregister;
> +
> +	queue = &dev->output_queue;
> +	queue->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +	queue->io_modes = VB2_DMABUF;
> +	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	queue->drv_priv = dev;
> +	queue->buf_struct_size = sizeof(struct vcam_buf);
> +	queue->ops = &vcam_vb2_ops;
> +	queue->mem_ops = &vb2_vmalloc_memops;
> +	queue->lock = &dev->lock;
> +	queue->dev = &dev->vdev->dev;
> +	ret = vb2_queue_init(queue);
> +	if (ret)
> +		goto err_capture_queue;
> +
> +	ret = vcam_ioc_alloc(file, dev, config->nr_frames,
> +			     u64_to_user_ptr(config->frames),
> +			     VB2_MEMORY_DMABUF);
> +	if (ret)
> +		goto err_output_queue;
> +
> +	ret = video_register_device(dev->vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret < 0)
> +		goto err_output_queue;
> +
> +	config->device_nr = dev->vdev->num;
> +	return 0;
> +
> +err_output_queue:
> +	vb2_queue_release(&dev->output_queue);
> +
> +err_capture_queue:
> +	vb2_queue_release(&dev->capture_queue);
> +
> +err_unregister:
> +	if (dev->vdev)
> +		video_device_release(dev->vdev);
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +err_modes:
> +	kfree(dev->modes);
> +	dev->modes = NULL;
> +	dev->nr_modes = 0;
> +	kfree(modes);
> +	return ret;
> +}
> +
> +static long vcam_ioctl(struct file *file, unsigned int cmd, unsigned long parm)
> +{
> +	struct vcam *dev = file->private_data;
> +	char card_label[VCAM_CARD_LABEL_MAX];
> +	struct vcam_ioc_create config;
> +	long ret, len;
> +
> +	if (cmd != VCAM_IOC_CREATE) {
> +		if (!dev || !test_bit(VCAM_FLAG_CREATING, &dev->flags) ||
> +		    !test_bit(VCAM_FLAG_READY, &dev->flags) ||
> +		    dev->device_nr < 0)
> +			return -ENOTTY;
> +		return vcam_ioctl_common(file, cmd, parm);
> +	}
> +
> +	if (!dev)
> +		return -ENOTTY;
> +
> +	if (test_and_set_bit(VCAM_FLAG_CREATING, &dev->flags))
> +		return -EBUSY;
> +
> +	if (!parm) {
> +		ret = -EINVAL;
> +		goto err_clear;
> +	}
> +
> +	if (copy_from_user(&config, (void *)parm, sizeof(config))) {
> +		ret = -EFAULT;
> +		goto err_clear;
> +	}
> +
> +	len = vcam_ioc_create_validate(&config, card_label);
> +	if (len < 0) {
> +		ret = len;
> +		goto err_clear;
> +	}
> +
> +	ret = vcam_ioc_create(file, dev, &config, card_label, len);
> +	if (ret)
> +		goto err_clear;
> +
> +	if (copy_to_user((void *)parm, &config, sizeof(config))) {
> +		ret = -EFAULT;
> +		goto err_release;
> +	}
> +
> +	dev->device_nr = dev->vdev->num;
> +	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "vcam-%d",
> +		 dev->device_nr);
> +	set_bit(VCAM_FLAG_READY, &dev->flags);
> +	return 0;
> +
> +err_release:
> +	__vcam_release(dev);
> +
> +err_clear:
> +	clear_bit(VCAM_FLAG_CREATING, &dev->flags);
> +	return ret;
> +}
> +
> +static const struct file_operations vcam_fops = {
> +	.owner = THIS_MODULE,
> +	.open = vcam_open,
> +	.unlocked_ioctl = vcam_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl = vcam_ioctl,
> +#endif
> +	.poll = vcam_poll,
> +	.mmap = vcam_mmap,
> +	.release = vcam_close,
> +	.llseek = noop_llseek,
> +};
> +
> +static struct miscdevice vcam_misc = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "vcam",
> +	.fops = &vcam_fops,
> +	.groups = vcam_attr_groups,
> +};
> +
> +module_misc_device(vcam_misc);
> diff --git a/include/uapi/linux/vcam.h b/include/uapi/linux/vcam.h
> new file mode 100644
> index 000000000000..a4b4d611ac58
> --- /dev/null
> +++ b/include/uapi/linux/vcam.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Copyright (c) Jarkko Sakkinen 2025-2026
> + */
> +
> +#ifndef _UAPI_LINUX_VCAM_H
> +#define _UAPI_LINUX_VCAM_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define VCAM_IOC_BASE 'v'
> +
> +/**
> + * DOC: vcam uAPI
> + *
> + * The ioctl API of /dev/vcam provides ioctls for creating DMA-BUF backed
> + * virtual capture devices, and pushing image frames for consumption.
> + *
> + * Frames are queued with %VCAM_IOC_QUEUE and recycled with %VCAM_IOC_DEQUEUE.
> + * Queueing without dequeuing eventually exhausts the output queue.
> + */
> +
> +/**
> + * enum vcam_status - Status bits
> + * @VCAM_STATUS_IDLE: Capture queue is not streaming.
> + * @VCAM_STATUS_STREAMING: Capture queue is streaming.
> + */
> +enum vcam_status {
> +	VCAM_STATUS_IDLE = 1U << 0,
> +	VCAM_STATUS_STREAMING = 1U << 1,
> +};
> +
> +/**
> + * struct vcam_mode - Supported capture mode
> + * @width: Frame width in pixels.
> + * @height: Frame height in pixels.
> + * @pixelformat: Four CC format code.
> + * @colorspace: V4L2 colorspace value.
> + * @stride: Bytes per line in the output format.
> + * @reserved: Reserved for future use. Must be set to zero.
> + */
> +struct vcam_mode {
> +	__u32 width;
> +	__u32 height;
> +	__u32 pixelformat;
> +	__u32 colorspace;
> +	__u32 stride;
> +	__u8 reserved[12];
> +};
> +
> +/**
> + * struct vcam_ioc_create - Create a virtual camera device
> + * @device_name: (input) User pointer to device name string.
> + * @device_nr: (output) Device number (must be 0 on input).
> + * @nr_modes: (input) Number of entries in @modes.
> + * @modes: (input) User pointer to an array of &struct vcam_mode.
> + * @reserved: Reserved for future use. Must be set to zero.
> + * @nr_frames: (input) Number of entries in @frames.
> + * @frames: (input/output) User pointer to an array of &struct vcam_frame.
> + */
> +struct vcam_ioc_create {
> +	__u64 device_name;
> +	__u32 device_nr;
> +	__u32 nr_modes;
> +	__u64 modes;
> +	__u32 reserved;
> +	__u32 nr_frames;
> +	__u64 frames;
> +};
> +
> +/**
> + * struct vcam_frame - a frame descriptor
> + * @index: Frame index assigned by the driver.
> + * @length: Frame size in bytes.
> + */
> +struct vcam_frame {
> +	__u32 index;
> +	__u32 length;
> +};
> +
> +/**
> + * struct vcam_ioc_queue - Produce an output buffer
> + * @fd: (input) DMA-BUF file descriptor.
> + * @index: (input) Buffer index for %VCAM_IOC_QUEUE.
> + * @length: (input) Payload length in bytes for %VCAM_IOC_QUEUE.
> + * @reserved: Reserved for future use. Must be set to zero.
> + * @timestamp: (input) Timestamp in nanoseconds for %VCAM_IOC_QUEUE.
> + */
> +struct vcam_ioc_queue {
> +	__u32 fd;
> +	__u32 index;
> +	__u32 length;
> +	__u32 reserved;
> +	__u64 timestamp;
> +};
> +
> +/**
> + * struct vcam_ioc_dequeue - Dequeue an output buffer
> + * @index: (output) Buffer index for %VCAM_IOC_DEQUEUE.
> + * @length: (output) Payload length in bytes for %VCAM_IOC_DEQUEUE.
> + * @timestamp: (output) Timestamp in nanoseconds for %VCAM_IOC_DEQUEUE.
> + */
> +struct vcam_ioc_dequeue {
> +	__u32 index;
> +	__u32 length;
> +	__u64 timestamp;
> +};
> +
> +/**
> + * struct vcam_ioc_wait - Wait for capture status
> + * @mask: (input) Mask of status bits to wait for. Set to zero to return
> + *         immediately.
> + * @status: (output) Current status bit mask.
> + * @mode: (output) User pointer to &struct vcam_mode.
> + * @reserved: Reserved for future use. Must be set to zero.
> + */
> +struct vcam_ioc_wait {
> +	__u64 mask;
> +	__u64 status;
> +	__u64 mode;
> +	__u64 reserved;
> +};
> +
> +/**
> + * DOC: vcam ioctls
> + *
> + * %VCAM_IOC_CREATE: Creates a virtual camera device, stores the allowed capture
> + * modes, and associates output buffers described by &struct vcam_frame with
> + * DMA-BUF file descriptors.
> + * %VCAM_IOC_QUEUE: Enqueues an output buffer for capture.
> + * %VCAM_IOC_DEQUEUE: Dequeues a consumed output buffer for reuse.
> + * %VCAM_IOC_WAIT: Waits for the subset of status bits to activate and returns
> + * the current status and capture mode.
> + */
> +#define VCAM_IOC_CREATE _IOWR(VCAM_IOC_BASE, 0x00, struct vcam_ioc_create)
> +#define VCAM_IOC_QUEUE _IOW(VCAM_IOC_BASE, 0x01, struct vcam_ioc_queue)
> +#define VCAM_IOC_DEQUEUE _IOR(VCAM_IOC_BASE, 0x02, struct vcam_ioc_dequeue)
> +#define VCAM_IOC_WAIT _IOWR(VCAM_IOC_BASE, 0x04, struct vcam_ioc_wait)
> +
> +#endif /* _UAPI_LINUX_VCAM_H */


