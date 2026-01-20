Return-Path: <linux-integrity+bounces-8285-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF3IDS0McGlyUwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8285-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jan 2026 00:13:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA804D963
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jan 2026 00:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB047A868BE
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5A36656C;
	Tue, 20 Jan 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFT3kz4V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92B3A8FE3;
	Tue, 20 Jan 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947892; cv=none; b=fuBjQMSp2/ICFBw87Pi5rBE/8akcRPwD/YPxRUDB7L2fXmspmNPPEAVP4bgde2NzomtgJEblwdWwhotl29mQqC4q2PreieEos6jP+SHd15pzVY282F0lihd9k04oQKonepMaEBx3UQyTkRBp5oGxkl02EGotdFUscI4Yfc2sY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947892; c=relaxed/simple;
	bh=kdKlYxhhmuicLAOuDNT3CJAUviaaiHIEM5ge9mB3eGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8D8mQj09eKHNgbzrx+UbWUAIH854apnUV64o/Y6pj88lU2dkoLWfuLuhBEN+0nd+R20dR1tNZbvQkU8TuI73eHmJW2Y7ZvbD6ckoXWHqZ+hZDTnGJY/Phlk7UhQ5pSdvQ744oYTbKOWCVWUPJ5xd1BaJ5v9lpmgaBW5aJTIluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFT3kz4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE1BC16AAE;
	Tue, 20 Jan 2026 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947890;
	bh=kdKlYxhhmuicLAOuDNT3CJAUviaaiHIEM5ge9mB3eGM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZFT3kz4VxK2dZJ/ubJGqUN5pZd1xeGE53w0NenplWdy3a1MQKP8fhbtVKjf2PdHUa
	 gdxcm/jbHHEwPWRPmxetMCXQk8egl0GQYrFhiCdS/G6ZEWe/cEBF6YJJ+o6Djhttnj
	 n3mqkCfjAQ7fSsX1fuB1NNzpveryIZyd1iJJrLQn4fT65lqbCvb0yBbGhfUWoNxj16
	 qmYk0Yd/nXnbV+wFT8/SkN7Kz5I8uI1UIU/0qWvkJ0I0ASUDfmAZacT+ASMeQgpazF
	 2/ik/EIMf8JdiHFMrY5+MWXxh3CRf6VjKudz/DmDx6EupEfXY77bLvoZta3sFeeWjQ
	 XrOjUEIIp+zkQ==
Message-ID: <0de47fe9d7c03398ce26c97739b69e89ecb425f2.camel@kernel.org>
Subject: Re: [PATCH v2] ima: Fallback to ctime check for FS without
 kstat.change_cookie
From: Jeff Layton <jlayton@kernel.org>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"	
 <serge@hallyn.com>, "Darrick J. Wong" <djwong@kernel.org>, Christian
 Brauner	 <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Date: Tue, 20 Jan 2026 17:24:48 -0500
In-Reply-To: <aW_4V93kczhzFjQ3@CMGLRV3>
References: <20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com>
	 <1a7985c825cf4af3b2a87e89793ae0daf2bb9c49.camel@kernel.org>
	 <aW_4V93kczhzFjQ3@CMGLRV3>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8285-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com,vger.kernel.org,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Queue-Id: 7AA804D963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 15:49 -0600, Frederick Lawler wrote:
> On Tue, Jan 20, 2026 at 04:22:55PM -0500, Jeff Layton wrote:
> > On Tue, 2026-01-20 at 14:20 -0600, Frederick Lawler wrote:
> > > Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > > introduced a means to track change detection for an inode
> > > via ctime updates, opposed to setting kstat.change_cookie to
> > > an i_version when calling into xfs_vn_getattr().
> > >=20
> > > This introduced a regression for IMA such that an action
> > > performed on a LOWER inode on a stacked file systems always
> > > requires a re-evaluation if the LOWER file system does not
> > > leverage kstat.change_cookie to track inode i_version or lacks
> > > i_version support all together.
> > >=20
> > > In the case of stacking XFS on XFS, an action on either the LOWER or =
UPPER
> > > will require re-evaluation. Stacking TPMFS on XFS for instance, once =
the
> > > inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> > > leverages generic_fillattr() to update the change cookie.
> > >=20
> > > This is because IMA caches kstat.change_cookie to compare against an
> > > inode's i_version directly in integrity_inode_attrs_changed(), and th=
us
> > > could be out of date depending on how file systems set
> > > kstat.change_cookie.
> > >=20
> > > To address this, require integrity_inode_attrs_changed() to query
> > > vfs_getattr_nosec() to compare the cached version against
> > > kstat.change_cookie directly. This ensures that when updates occur,
> > > we're accessing the same changed inode version on changes, and fallba=
ck
> > > to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing fr=
om
> > > result mask.
> > >=20
> > > Lastly, because EVM still relies on querying and caching a inode's
> > > i_version directly, the integrity_inode_attrs_changed() falls back to=
 the
> > > original inode.i_version !=3D cached comparison.
> > >=20
> > > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > ---
> > > We uncovered a case in kernels >=3D 6.13 where XFS is no longer updat=
ing
> > > struct kstat.change_cookie on i_op getattr() access calls. Instead, X=
FS is
> > > using multigrain ctime (as well as other file systems) for
> > > change detection in commit 1cf7e834a6fb ("xfs: switch to
> > > multigrain timestamps").
> > >=20
> > > Because file systems may implement i_version as they see fit, IMA
> > > caching may be behind as well as file systems that don't support/expo=
rt
> > > i_version. Thus we're proposing to compare against the kstat.change_c=
ookie
> > > directly to the cached version, and fall back to a ctime guard when
> > > that's not updated.
> > >=20
> > > EVM is largely left alone since there's no trivial way to query a fil=
e
> > > directly in the LSM call paths to obtain kstat.change_cookie &
> > > kstat.ctime to cache. Thus retains accessing i_version directly.
> > >=20
> > > Regression tests will be added to the Linux Test Project instead of
> > > selftest to help catch future file system changes that may impact
> > > future evaluation of IMA.
> > >=20
> > > I'd like this to be backported to at least 6.18 if possible.
> > >=20
> > > Below is a simplified test that demonstrates the issue:
> > >=20
> > > _fragment.config_
> > > CONFIG_XFS_FS=3Dy
> > > CONFIG_OVERLAY_FS=3Dy
> > > CONFIG_IMA=3Dy
> > > CONFIG_IMA_WRITE_POLICY=3Dy
> > > CONFIG_IMA_READ_POLICY=3Dy
> > >=20
> > > _./test.sh_
> > >=20
> > > IMA_POLICY=3D"/sys/kernel/security/ima/policy"
> > > TEST_BIN=3D"/bin/date"
> > > MNT_BASE=3D"/tmp/ima_test_root"
> > >=20
> > > mkdir -p "$MNT_BASE"
> > > mount -t tmpfs tmpfs "$MNT_BASE"
> > > mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}
> > >=20
> > > dd if=3D/dev/zero of=3D"$MNT_BASE/xfs.img" bs=3D1M count=3D300
> > > mkfs.xfs -q "$MNT_BASE/xfs.img"
> > > mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
> > > cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"
> > >=20
> > > mount -t overlay overlay -o \
> > > "lowerdir=3D$MNT_BASE/xfs_disk,upperdir=3D$MNT_BASE/upper,workdir=3D$=
MNT_BASE/work" \
> > > "$MNT_BASE/ovl"
> > >=20
> > > echo "audit func=3DBPRM_CHECK uid=3D$(id -u nobody)" > "$IMA_POLICY"
> > >=20
> > > target_prog=3D"$MNT_BASE/ovl/test_prog"
> > > setpriv --reuid nobody "$target_prog"
> > > setpriv --reuid nobody "$target_prog"
> > > setpriv --reuid nobody "$target_prog"
> > >=20
> > > audit_count=3D$(dmesg | grep -c "file=3D\"$target_prog\"")
> > >=20
> > > if [[ "$audit_count" -eq 1 ]]; then
> > >         echo "PASS: Found exactly 1 audit event."
> > > else
> > >         echo "FAIL: Expected 1 audit event, but found $audit_count."
> > >         exit 1
> > > fi
> > > ---
> > > Changes since RFC:
> > > - Remove calls to I_IS_VERSION()
> > > - Function documentation/comments
> > > - Abide IMA/EVM change detection fallback invariants
> > > - Combined ctime guard into version for attributes struct
> > > - Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-=
6a717c939f7c@cloudflare.com
> > > ---
> > > Changes in v2:
> > > - Updated commit description + message to clarify the problem.
> > > - compare struct timespec64 to avoid collision possibility [Roberto].
> > > - Don't check inode_attr_changed() in ima_check_last_writer()
> > > - Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8=
d13b6001312@cloudflare.com
> > > ---
> > >  include/linux/integrity.h           | 40 +++++++++++++++++++++++++++=
+++++-----
> > >  security/integrity/evm/evm_crypto.c |  4 +++-
> > >  security/integrity/evm/evm_main.c   |  5 ++---
> > >  security/integrity/ima/ima_api.c    | 20 +++++++++++++------
> > >  security/integrity/ima/ima_main.c   | 18 ++++++++++-------
> > >  5 files changed, 65 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > > index f5842372359be5341b6870a43b92e695e8fc78af..46f57402b790c9c275b85=
f0b30819fa196fc20c7 100644
> > > --- a/include/linux/integrity.h
> > > +++ b/include/linux/integrity.h
> > > @@ -9,6 +9,8 @@
> > > =20
> > >  #include <linux/fs.h>
> > >  #include <linux/iversion.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/time64.h>
> > > =20
> > >  enum integrity_status {
> > >  	INTEGRITY_PASS =3D 0,
> > > @@ -31,6 +33,7 @@ static inline void integrity_load_keys(void)
> > > =20
> > >  /* An inode's attributes for detection of changes */
> > >  struct integrity_inode_attributes {
> > > +	struct timespec64 ctime;
> > >  	u64 version;		/* track inode changes */
> > >  	unsigned long ino;
> > >  	dev_t dev;
> > > @@ -42,8 +45,10 @@ struct integrity_inode_attributes {
> > >   */
> > >  static inline void
> > >  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs=
,
> > > -			    u64 i_version, const struct inode *inode)
> > > +			    u64 i_version, struct timespec64 ctime,
> > > +			    const struct inode *inode)
> > >  {
> > > +	attrs->ctime =3D ctime;
> > >  	attrs->version =3D i_version;
> > >  	attrs->dev =3D inode->i_sb->s_dev;
> > >  	attrs->ino =3D inode->i_ino;
> > > @@ -51,14 +56,39 @@ integrity_inode_attrs_store(struct integrity_inod=
e_attributes *attrs,
> > > =20
> > >  /*
> > >   * On stacked filesystems detect whether the inode or its content ha=
s changed.
> > > + *
> > > + * Must be called in process context.
> > >   */
> > >  static inline bool
> > >  integrity_inode_attrs_changed(const struct integrity_inode_attribute=
s *attrs,
> > > -			      const struct inode *inode)
> > > +			      struct file *file, struct inode *inode)
> > >  {
> > > -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> > > -		inode->i_ino !=3D attrs->ino ||
> > > -		!inode_eq_iversion(inode, attrs->version));
> > > +	struct kstat stat;
> > > +
> > > +	might_sleep();
> > > +
> > > +	if (inode->i_sb->s_dev !=3D attrs->dev || inode->i_ino !=3D attrs->=
ino)
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * EVM currently relies on backing inode i_version. While IS_I_VERS=
ION
> > > +	 * is not a good indicator of i_version support, this still retains
> > > +	 * the logic such that a re-evaluation should still occur for EVM, =
and
> > > +	 * only for IMA if vfs_getattr_nosec() fails.
> > > +	 */
> > > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > > +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> > > +				       AT_STATX_SYNC_AS_STAT))
> > > +		return !IS_I_VERSION(inode) ||
> > > +			!inode_eq_iversion(inode, attrs->version);
> >=20
> > Seems like a reasonable way to handle getattr failure, given the
> > limitations on EVM.
> >=20
> > > +
> > > +	if (stat.result_mask & STATX_CHANGE_COOKIE)
> > > +		return stat.change_cookie !=3D attrs->version;
> > > +
> > > +	if (stat.result_mask & STATX_CTIME)
> > > +		return !timespec64_equal(&stat.ctime, &attrs->ctime);
> > > +
> > > +	return true;
> > >  }
> > > =20
> > > =20
> > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity=
/evm/evm_crypto.c
> > > index a5e730ffda57fbc0a91124adaa77b946a12d08b4..361ee7b216247a0d6d2f5=
18e82fb6e92dc355afe 100644
> > > --- a/security/integrity/evm/evm_crypto.c
> > > +++ b/security/integrity/evm/evm_crypto.c
> > > @@ -297,10 +297,12 @@ static int evm_calc_hmac_or_hash(struct dentry =
*dentry,
> > >  	hmac_add_misc(desc, inode, type, data->digest);
> > > =20
> > >  	if (inode !=3D d_backing_inode(dentry) && iint) {
> > > +		struct timespec64 ctime =3D {0};
> > > +
> > >  		if (IS_I_VERSION(inode))
> > >  			i_version =3D inode_query_iversion(inode);=20
> >=20
> > It would be nice if you could change this codepath as well, but that
> > looks like a much bigger project. FWIW, I took a quick look:
> >=20
> > The problematic codepath is get/setxattr, which can call into this but
> > currently only receives a dentry and not a struct path. That would
> > probably have to be changed. I think it's doable but it's a fair bit of
> > yak shaving.
>=20
> Agreed. I was looking at that a couple weeks ago to include a patch 2
> for EVM, and came to the same conclusion. I did find struct iattr on the
> setxattr which has struct file *, but that seemed dubious to at best.
>=20

Yeah, it's not set in all cases. setxattr is a pathname-based
operation, so an open file sometimes just doesn't exist.
=20
> Alternatively, create security_get/setxattr() equivalent hooks, or
> have an internal mapping of sorts.
>=20

>=20
Those are possibilities too.

A dentry without a mount is somewhat ambiguous though. IMO, it would be
best to just change all of the xattr_handler functions to take struct
path instead of a dentry.

Maybe a good topic for LSF/MM...

> > >  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> > > -					    inode);
> > > +					    ctime, inode);
> > >  	}
> > > =20
> > >  	/* Portable EVM signatures must include an IMA hash */
> > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/e=
vm/evm_main.c
> > > index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b=
1db590c1759242b9cb6 100644
> > > --- a/security/integrity/evm/evm_main.c
> > > +++ b/security/integrity/evm/evm_main.c
> > > @@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, st=
ruct inode *metadata_inode)
> > >  	bool ret =3D false;
> > > =20
> > >  	if (iint) {
> > > -		ret =3D (!IS_I_VERSION(metadata_inode) ||
> > > -		       integrity_inode_attrs_changed(&iint->metadata_inode,
> > > -						     metadata_inode));
> > > +		ret =3D integrity_inode_attrs_changed(&iint->metadata_inode,
> > > +						    NULL, metadata_inode);
> > >  		if (ret)
> > >  			iint->evm_status =3D INTEGRITY_UNKNOWN;
> > >  	}
> > > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/im=
a/ima_api.c
> > > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..0d8e0a3ebd34b70bb1b4c=
c995aae5d4adc90a585 100644
> > > --- a/security/integrity/ima/ima_api.c
> > > +++ b/security/integrity/ima/ima_api.c
> > > @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache=
 *iint, struct file *file,
> > >  	int length;
> > >  	void *tmpbuf;
> > >  	u64 i_version =3D 0;
> > > +	struct timespec64 ctime =3D {0};
> > > =20
> > >  	/*
> > >  	 * Always collect the modsig, because IMA might have already collec=
ted
> > > @@ -272,10 +273,15 @@ int ima_collect_measurement(struct ima_iint_cac=
he *iint, struct file *file,
> > >  	 * to an initial measurement/appraisal/audit, but was modified to
> > >  	 * assume the file changed.
> > >  	 */
> > > -	result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COO=
KIE,
> > > +	result =3D vfs_getattr_nosec(&file->f_path, &stat,
> > > +				   STATX_CHANGE_COOKIE | STATX_CTIME,
> > >  				   AT_STATX_SYNC_AS_STAT);
> > > -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > > -		i_version =3D stat.change_cookie;
> > > +	if (!result) {
> > > +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> > > +			i_version =3D stat.change_cookie;
> > > +		if (stat.result_mask & STATX_CTIME)
> > > +			ctime =3D stat.ctime;
> > > +	}
> > >  	hash.hdr.algo =3D algo;
> > >  	hash.hdr.length =3D hash_digest_size[algo];
> > > =20
> > > @@ -305,11 +311,13 @@ int ima_collect_measurement(struct ima_iint_cac=
he *iint, struct file *file,
> > > =20
> > >  	iint->ima_hash =3D tmpbuf;
> > >  	memcpy(iint->ima_hash, &hash, length);
> > > -	if (real_inode =3D=3D inode)
> > > +	if (real_inode =3D=3D inode) {
> > >  		iint->real_inode.version =3D i_version;
> > > -	else
> > > +		iint->real_inode.ctime =3D ctime;
> > > +	} else {
> > >  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> > > -					    real_inode);
> > > +					    ctime, real_inode);
> > > +	}
> > > =20
> > >  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
> > >  	if (!result)
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/i=
ma/ima_main.c
> > > index 5770cf691912aa912fc65280c59f5baac35dd725..54b638663c9743d39e5fb=
65711dbd9698b38e39b 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -22,12 +22,14 @@
> > >  #include <linux/mount.h>
> > >  #include <linux/mman.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/stat.h>
> > >  #include <linux/xattr.h>
> > >  #include <linux/ima.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/iversion.h>
> > >  #include <linux/evm.h>
> > >  #include <linux/crash_dump.h>
> > > +#include <linux/time64.h>
> > > =20
> > >  #include "ima.h"
> > > =20
> > > @@ -199,10 +201,13 @@ static void ima_check_last_writer(struct ima_ii=
nt_cache *iint,
> > >  					    &iint->atomic_flags);
> > >  		if ((iint->flags & IMA_NEW_FILE) ||
> > >  		    vfs_getattr_nosec(&file->f_path, &stat,
> > > -				      STATX_CHANGE_COOKIE,
> > > -				      AT_STATX_SYNC_AS_STAT) ||
> > > -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> > > -		    stat.change_cookie !=3D iint->real_inode.version) {
> > > +			    STATX_CHANGE_COOKIE | STATX_CTIME,
> > > +			    AT_STATX_SYNC_AS_STAT) ||
> > > +		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
> > > +		      stat.change_cookie !=3D iint->real_inode.version :
> > > +		      (!(stat.result_mask & STATX_CTIME) ||
> > > +			!timespec64_equal(&stat.ctime,
> > > +					  &iint->real_inode.ctime)))) {
> > >  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
> > >  			iint->measured_pcrs =3D 0;
> > >  			if (update)
> > > @@ -328,9 +333,8 @@ static int process_measurement(struct file *file,=
 const struct cred *cred,
> > >  	real_inode =3D d_real_inode(file_dentry(file));
> > >  	if (real_inode !=3D inode &&
> > >  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> > > -		if (!IS_I_VERSION(real_inode) ||
> > > -		    integrity_inode_attrs_changed(&iint->real_inode,
> > > -						  real_inode)) {
> > > +		if (integrity_inode_attrs_changed(&iint->real_inode,
> > > +						  file, real_inode)) {
> > >  			iint->flags &=3D ~IMA_DONE_MASK;
> > >  			iint->measured_pcrs =3D 0;
> > >  		}
> > >=20
> > > ---
> > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > change-id: 20251212-xfs-ima-fixup-931780a62c2c
> > >=20
> > > Best regards,
> >=20
> > Looks like a good change overall. Thanks for fixing this up. I don't
> > know IMA or EVM very well, so FWIW:
>=20
> Thanks! Fun investigation & fix.
>=20
> >=20
> > Acked-by: Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

